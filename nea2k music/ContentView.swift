//
//  ContentView.swift
//  nea2k music
//
//  Created by Yohey Kuwabara on 2022/02/20.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct ContentView: View {
    @ObservedObject var model = playerModel()
    
    @State var activity: Activity<widgetAttributes>?
    @State var playing = false
    
   
    
    var body: some View {
        NavigationView{
            List {
                Section {
                    NavigationLink(destination: iPod1st_View(model: model)) {
                        Text("iPod 1st")
                    }
                    NavigationLink(destination: iPodAquaView(model: model)) {
                        Text("iPod Aqua")
                    }
                }header: {
                    Text("skins")
                }
            }
            .navigationTitle("NEA2K Music")
            
        }
        .onAppear(perform: {
            model.getMediaInfo()
            WidgetCenter.shared.reloadAllTimelines()
            ///startActivity()
        })
    }
    
    func startActivity(){
        print("start activity")
        
        if model.musicPlayer.playbackState == .playing{
            playing = true
        }else{
            playing = false
        }
        let attributes = widgetAttributes(name: "name")
        let state = widgetAttributes.ContentState(songTitle: model.songTitle, artistName: model.artistName, playing: playing, batterySymbol: model.batterySymbol)
        
        do {
            activity = try Activity<widgetAttributes>.request(attributes: attributes, contentState: state)
            
        }catch (let error) {
            print("error has occured", error)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

