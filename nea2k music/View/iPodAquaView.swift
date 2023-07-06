//
//  iPod1st_View.swift
//  nea2k music
//
//  Created by Yohey Kuwabara on 2022/02/21.
//

import Foundation
import SwiftUI
import MusicKit

struct iPodAquaView: View {
    @ObservedObject var model: playerModel ///= playerModel()
    
    var body: some View {
        VStack(){
            GeometryReader{ geometry in
                ZStack{
                    Color.black
                    iPodAquaDisplay(model: model)
                        .padding(8)
                }
                .cornerRadius(10)
                .frame(width: geometry.size.width/1.2, height: geometry.size.width/1.6)
                .offset(x: (geometry.size.width - geometry.size.width/1.2)/2, y: 0)
            }
            ///iPodButtons(model: model)
                .padding()
            
            Spacer()
        }
        .background(Color.iPod1stBG)
    }
}

///struct iPodAquaView_Previews: PreviewProvider {
    ///static var previews: some View {
        ///iPodAquaView()
    ///}
///}

extension Color {
    static let ab1 = Color("aqua bar 1")
    static let ab2 = Color("aqua bar 2")
    static let ab3 = Color("aqua bar 3")
}

struct iPodAquaDisplay: View {
    @ObservedObject var model: playerModel
    
    var body: some View{
        VStack{
            ZStack{
                HStack(alignment: .center){
                    ZStack{
                        if model.musicPlayer.playbackState == .playing{
                            Image(systemName: "play.fill")
                                .foregroundColor(.blue)
                                .frame(width: 16.0, height: 16.0)
                                .font(.body)
                                
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                                .frame(width: 16.0, height: 16.0)
                                .font(.caption)
                                .opacity(0.5)
                                .blur(radius: 2)
                        }else {
                            Image(systemName: "pause.fill")
                                .foregroundColor(.blue)
                                .frame(width: 16.0, height: 16.0)
                                .font(.body)
                                
                            Image(systemName: "pause.fill")
                                .foregroundColor(.white)
                                .frame(width: 16.0, height: 16.0)
                                .font(.caption)
                                .opacity(0.5)
                                .blur(radius: 2)
                        }
                    }
                    Spacer()
                    Image(systemName: model.batterySymbol)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                HStack{
                    Text("Now Playing")
                        .font(.custom("Lucida Grande", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: 320, height: 34)
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [.ab1, .ab2, .ab3]), startPoint: .top, endPoint: .bottom))
            
            Spacer()
            
            HStack{
                if model.musicPlayer.nowPlayingItem?.artwork != nil{
                    Image(uiImage: (model.musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 200, height: 200)))!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .padding()
                }
                VStack(){
                    Button(action: {
                        self.model.showPicker.toggle()
                    }) {
                        Text(model.musicPlayer.nowPlayingItem?.title ?? String("song title"))
                            .font(.custom("Lucida Grande", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .underline()
                            .padding(5)
                    }
                    .sheet(isPresented: $model.showPicker, onDismiss: {
                        model.picker()
                    }, content: {
                        MusicPicker(collection: $model.collection, isPicked: $model.isPicked)
                    })
                    
                    Text(model.musicPlayer.nowPlayingItem?.artist ?? String("artist name"))
                        .font(.custom("Lucida Grande", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(5)
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .background(Color.white)
        ///.clipShape(ContainerRelativeShape())
    }
}

