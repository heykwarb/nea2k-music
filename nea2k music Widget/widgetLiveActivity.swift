//
//  widgetLiveActivity.swift
//  widget
//
//  Created by Yohey Kuwabara on 2022/10/21.
//

import ActivityKit
import WidgetKit
import SwiftUI
import MediaPlayer

struct widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var songTitle: String
        var artistName: String
        var playing: Bool
        var batterySymbol: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct widgetLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            GeometryReader{ geometry in
                ZStack(alignment: .center){
                    Color.chicagoBG
                    
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                        path.closeSubpath()
                    }
                    .fill()
                    .foregroundColor(.black)
                    .opacity(0.8)
                    .blur(radius: 10)
                    
                    Path { path in
                        path.move(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                        path.closeSubpath()
                    }
                    .fill()
                    .foregroundColor(.black)
                    .opacity(0.5)
                    .blur(radius: 10)
                    
                    Color.chicagoBG
                        .clipShape(ContainerRelativeShape())
                        .padding(4)
                        .blur(radius: 3)
                    
                    VStack(alignment: .center){
                        ZStack{
                            HStack(alignment: .center){
                                if context.state.playing{
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.chicagoText)
                                }else {
                                    Image(systemName: "pause.fill")
                                        .foregroundColor(.chicagoText)
                                }
                                Spacer()
                                Image(systemName: context.state.batterySymbol)
                                    .foregroundColor(.chicagoText)
                                
                                
                            }
                            Text("Now Playing")
                                .font(.custom("Chicago", size: 18))
                                .foregroundColor(.chicagoText)
                                .offset(x: 0, y: 3)
                            
                            
                        }
                        Rectangle()
                            .frame(width: geometry.size.width - 30, height: 2)
                            .foregroundColor(.chicagoText)
                        Spacer()
                        Text(context.state.songTitle)
                            .font(.custom("Chicago", size: 28))
                            .foregroundColor(.chicagoText)
                        Text(context.state.artistName)
                            .font(.custom("Chicago", size: 22))
                            .foregroundColor(.chicagoText)
                        Spacer()
                            
                    }
                    .padding()
                }
            }
            .activityBackgroundTint(Color.chicagoBG)
            .activitySystemActionForegroundColor(Color.chicagoText)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                
                }
            } compactLeading: {
                
            } compactTrailing: {
                
            } minimal: {
                
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

