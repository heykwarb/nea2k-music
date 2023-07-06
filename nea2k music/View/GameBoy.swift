//
//  GameBoy.swift
//  nea2k music
//
//  Created by Yohey Kuwabara on 2022/03/15.
//

import SwiftUI

struct GameBoy: View {
    @ObservedObject var model: playerModel
    var body: some View {
        VStack{
            ZStack{
                Color.black
                gameBoyDisplay(model: model)
            }
            .frame(width: 380, height: 380)
            .cornerRadius(10)
            
            gameBoyButtons(model: model)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }
    }
}

struct gameBoyDisplay: View {
    @ObservedObject var model: playerModel
    
    var body: some View{
        VStack{
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
        .frame(width: 280, height: 280)
        .background(Color.gray)
    }
}

struct gameBoyButtons: View {
    @ObservedObject var model: playerModel
    @State var frameSize: CGFloat = 140
    let hapticLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View{
        HStack(){
            ZStack{
                Image("gameboy_buttons cross")
                    .resizable()
                    .frame(width: frameSize, height: frameSize)
                    .shadow(radius: 5)
                Button(action: {
                    hapticLight.impactOccurred()
                }){
                    ZStack{
                        Circle()
                            .frame(width: frameSize/3, height: frameSize/3)
                            .foregroundColor(.white.opacity(0))
                        Image(systemName: "speaker.wave.1.fill")
                            .foregroundColor(.black)
                    }
                }
                .offset(y: frameSize/3)
                
                Button(action: {
                    hapticLight.impactOccurred()
                }){
                    ZStack{
                        Circle()
                            .frame(width: frameSize/3, height: frameSize/3)
                            .foregroundColor(.white.opacity(0))
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.black)
                    }
                }
                .offset(y: -frameSize/3)
                
                Button(action: {
                    model.forward()
                    hapticLight.impactOccurred()
                }){
                    ZStack{
                        Circle()
                            .frame(width: frameSize/3, height: frameSize/3)
                            .foregroundColor(.white.opacity(0))
                        Image(systemName: "forward.fill")
                            .foregroundColor(.black)
                    }
                }
                .offset(x: frameSize/3)
                
                Button(action: {
                    model.backward()
                    hapticLight.impactOccurred()
                }){
                    ZStack{
                        Circle()
                            .frame(width: frameSize/3, height: frameSize/3)
                            .foregroundColor(.white.opacity(0))
                        Image(systemName: "backward.fill")
                            .foregroundColor(.black)
                    }
                }
                .offset(x: -frameSize/3)
            }
            .padding()
            
            Spacer()
            
            VStack{
                Spacer()
                Button(action: {
                    model.musicPlayer.pause()
                    hapticLight.impactOccurred()
                }){
                    ZStack{
                        Image("gameboy_buttons circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .shadow(radius: 5)
                        Image(systemName: "pause.fill")
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.horizontal)
            }
            .frame(height: frameSize)
            
            VStack{
                Button(action: {
                    model.musicPlayer.play()
                    hapticLight.impactOccurred()
                }){
                    ZStack{
                        Image("gameboy_buttons circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .shadow(radius: 5)
                        Image(systemName: "play.fill")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .frame(height: frameSize)
            ///.padding()
        }
    }
}
