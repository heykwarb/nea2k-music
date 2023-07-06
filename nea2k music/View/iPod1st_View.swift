//
//  iPod1st_View.swift
//  nea2k music
//
//  Created by Yohey Kuwabara on 2022/02/21.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct iPod1st_View: View {
    @ObservedObject var model: playerModel ///= playerModel()
    
    @State var activity: Activity<widgetAttributes>?
    @State var playing = false
    
    var body: some View {
        VStack{
            Button("load widget"){
                WidgetCenter.shared.reloadAllTimelines()
            }
            GeometryReader{ geometry in
                ZStack(){
                    Color.chicagoBG
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: geometry.size.width/1.2, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: geometry.size.width/1.6))
                        path.closeSubpath()
                    }
                    .fill()
                    .foregroundColor(.black)
                    .opacity(0.8)
                    .blur(radius: 10)
                    
                    Path { path in
                        path.move(to: CGPoint(x: geometry.size.width/1.2, y: geometry.size.width/1.6))
                        path.addLine(to: CGPoint(x: geometry.size.width/1.2, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: geometry.size.width/1.6))
                        path.closeSubpath()
                    }
                    .fill()
                    .foregroundColor(.black)
                    .opacity(0.5)
                    .blur(radius: 10)
                    
                    Color.chicagoBG
                        .clipShape(ContainerRelativeShape())
                        .padding(2)
                        .blur(radius: 6)
                    
                    VStack(){
                        ZStack{
                            HStack(){
                                Image(systemName: model.playbackStateImage)
                                    .foregroundColor(.chicagoText)
                                
                                Spacer()
                                Image(systemName: model.batterySymbol)
                                    .foregroundColor(.chicagoText)
                            }
                            Text("Now Playing")
                                .font(.custom("Chicago", size: 18))
                                .foregroundColor(.chicagoText)
                                .offset(x: 0, y: 3)
                        }
                        .padding([.top, .leading, .trailing])
                        
                        Rectangle()
                            .padding(.horizontal)
                            .frame(height: 2)
                            .foregroundColor(.chicagoText)
                        
                        Spacer()
                        
                        //song title
                        Button(action: {
                            self.model.showPicker.toggle()
                            startActivity()
                        }){
                            Text(model.songTitle)
                                .font(.custom("Chicago", size: 28))
                                .foregroundColor(.chicagoText)
                                .underline()
                        }
                        .padding(.horizontal)
                        .sheet(isPresented: $model.showPicker, onDismiss: {
                            model.picker()
                        }, content: {
                            MusicPicker(collection: $model.collection, isPicked: $model.isPicked)
                        })
                        
                        Text(model.artistName)
                            .font(.custom("Chicago", size: 22))
                            .foregroundColor(.chicagoText)
                            .padding(.horizontal)
                        
                        ZStack{
                            Rectangle()
                                .stroke(Color.chicagoText, lineWidth: 2)
                                .frame(width: model.progressBar, height: 18.0)
                                .padding(.horizontal)
                            Rectangle()
                                .frame(width: model.progress, height: 18.0)
                                .foregroundColor(.chicagoText)
                                
                                .offset(x: model.progressOffset)
                        }
                        
                        HStack(alignment: .center){
                            Text(model.cPTime)
                                .font(.custom("Chicago", size: 16))
                                .foregroundColor(.chicagoText)
                            Spacer()
                            Text(model.pDuration)
                                .font(.custom("Chicago", size: 16))
                                .foregroundColor(.chicagoText)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            
                    }
                }
                .frame(width: geometry.size.width/1.2, height: geometry.size.width/1.6)
                .cornerRadius(10)
                .offset(x: (geometry.size.width - geometry.size.width/1.2)/2, y: 0)
            }
            
            iPodWheel(model: model)
                .padding()
                .offset(y: -80)
        }
        .background(Color.iPod1stBG)
        
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

///struct iPod1stView_Previews: PreviewProvider {
    ///static var previews: some View {
        ///iPod1st_View(model: <#playerModel#>)
   /// }
///}
