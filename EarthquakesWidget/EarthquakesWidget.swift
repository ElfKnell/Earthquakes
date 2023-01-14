//
//  EarthquakesWidget.swift
//  EarthquakesWidget
//
//  Created by Andrii Kyrychenko on 13/01/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    var providerQuake = QuakeClient()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quakes: [Quake.preview])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            var quakes = [Quake.preview]
            
            do {
                quakes = try await providerQuake.quakes
            } catch {
                print(error.localizedDescription)
            }
            
            let entry = SimpleEntry(date: Date(), quakes: quakes)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {
            var quakes = [Quake.preview]
            
            do {
                quakes = try await providerQuake.quakes
            } catch {
                print(error.localizedDescription)
            }
            
            let entries = SimpleEntry(date: .now, quakes: quakes)
            
            let timeline = Timeline(entries: [entries], policy: .after(.now.advanced(by: 60 * 60 * 60)))
            
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    
    let quakes: [Quake]
}

struct EarthquakesWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("\(entry.quakes[0].time.formatted(.relative(presentation: .named)))")
                .foregroundStyle(.foreground)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(.black)
                .frame(width: 80, height: 60)
                .overlay {
                    Text("\(entry.quakes[0].magnitude.formatted(.number.precision(.fractionLength(1))))")
                        .font(.title)
                        .bold()
                        .foregroundStyle(entry.quakes[0].color)
                }
            
            Text(entry.quakes[0].place)
                .font(.title3)
                .frame(height: 50)
                .minimumScaleFactor(0.7)
        }
        .padding()
    }
}

struct EarthquakesWidget: Widget {
    let kind: String = "EarthquakesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EarthquakesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Earthquakes Widget")
        .description("This widget shows the last earthquake.")
    }
}

struct EarthquakesWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        EarthquakesWidgetEntryView(entry: SimpleEntry(date: Date(), quakes: [Quake.preview]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
