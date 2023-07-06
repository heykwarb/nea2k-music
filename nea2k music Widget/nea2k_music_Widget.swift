//
//  nea2k_music_widget.swift
//  nea2k music widget
//
//  Created by Yohey Kuwabara on 2022/02/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), songTitle: "songTitle", artistName: "artistName", isPlaying: false, batterySymbol: "")
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: ConfigurationIntent(), songTitle: "songTitle", artistName: "artistName", isPlaying: false, batterySymbol: "")
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        var songTitle = "song title"
        var artistName = ""
        var isPlaying = false
        var batterySymbol = ""
        
        if let userDefaults = UserDefaults(suiteName: "group.com.heykwarb.widgetest"){
            print("user defaults")
            songTitle = userDefaults.string(forKey: "songTitle")!
            artistName = userDefaults.string(forKey: "artistName")!
            isPlaying = userDefaults.bool(forKey: "isPlaying")
            batterySymbol = userDefaults.string(forKey: "batterySymbol")!
        }
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            
            let entry = SimpleEntry(date: Date(), configuration: ConfigurationIntent(), songTitle: songTitle, artistName: artistName, isPlaying: isPlaying, batterySymbol: batterySymbol)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    var songTitle: String
    var artistName: String
    var isPlaying: Bool
    var batterySymbol: String
}

//Widget
struct nea2k_music_Widget: Widget {
    let kind: String = "nea2k_music_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            nea2k_music_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Now Playing")
        .description("Display what playing now")
        .supportedFamilies([.systemLarge, .systemMedium])
    }
}

//Widget Entry View
struct nea2k_music_widgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        iPod1st_Widget(songTitle: entry.songTitle, artistName: entry.artistName, isPlaying: entry.isPlaying, batterySymbol: entry.batterySymbol)
    }
}

//previews

struct nea2k_music_widget_medium_Previews: PreviewProvider {
    static var previews: some View {
        nea2k_music_widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), songTitle: "", artistName: "", isPlaying: true, batterySymbol: ""))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

struct nea2k_music_widget_large_Previews: PreviewProvider {
    static var previews: some View {
        nea2k_music_widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), songTitle: "", artistName: "", isPlaying: true, batterySymbol: ""))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
