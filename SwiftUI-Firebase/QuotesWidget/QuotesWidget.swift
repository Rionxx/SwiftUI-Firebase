//
//  QuotesWidget.swift
//  QuotesWidget
//
//  Created by FX on 2021/09/05.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let encodedData = UserDefaults(suiteName: "group.com.Quotes.quoteContainer")!.object(forKey: "quoteData") as! Data
        
        if let quoteEncoded = encodedData {
            let quoteDecoded = try? JSONDecoder().decode([Quote].self, form: quoteEncoded)
            if let quoteData = quoteDecoded {
                // load Data
                
            }
        }
        

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let quoteText: String = "Helli World"
    let liked: Bool = false
    let quote:
    let configuration: ConfigurationIntent
}

struct QuotesWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.quoteText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Image(systemName: entry.liked ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .padding(.all)
        }
        .padding(.all)
    }
}

@main
struct QuotesWidget: Widget {
    let kind: String = "QuotesWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            QuotesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Quotes")
        .description("Get a dose of inspiration")
    }
}

struct QuotesWidget_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            QuotesWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            QuotesWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
