//
//  OP1styleView.swift
//  nea2k music
//
//  Created by Yohey Kuwabara on 2022/03/22.
//

import SwiftUI

struct OP1styleView: View {
    @ObservedObject var model: playerModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 90), spacing: 5),
        GridItem(.flexible(minimum: 90), spacing: 5),
        GridItem(.flexible(minimum: 90), spacing: 5),
        GridItem(.flexible(minimum: 90), spacing: 5)]
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.op1BG1, .op1BG2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack(spacing:0){
                    let size = (geometry.size.width/1.2)/4
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: size*2-10, height: size*2-10)
                            .foregroundColor(.black)
                            .offset(x: -size-5*2)
                        
                        Image("op1_speaker_1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: size*2)
                            .shadow(radius: 4)
                            .offset(x: -size-5*2)
                            ///.padding()
                    }
                    
                    
                    ZStack{
                        ///RoundedRectangle(cornerRadius: 8)
                            ///.shadow(color: .white, radius: 8, x: 6, y: 6)
                        Color.black
                        
                        VStack{
                            Text("\(model.cPTime) / \(model.pDuration)")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                            
                            Button(action: {
                                self.model.showPicker.toggle()
                            }){
                                VStack{
                                    Text(model.musicPlayer.nowPlayingItem?.title ?? String("song title"))
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                    Text(model.musicPlayer.nowPlayingItem?.artist ?? String("artist name"))
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            }
                            .sheet(isPresented: $model.showPicker, onDismiss: {
                                model.picker()
                            }, content: {
                                MusicPicker(collection: $model.collection, isPicked: $model.isPicked)
                            })
                        }
                        .padding()
                    }
                    .frame(width: geometry.size.width / 1.2 + 5*5, height: geometry.size.width / 2)
                    .cornerRadius(20)
                    .padding()
                    
                    HStack{
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            Button(action: {model.backward()}) {
                                OP1button3D(size: size, buttonName: "backward.fill", buttonColor: .white.opacity(0))
                            }
                            
                            Button(action: {model.musicPlayer.play()}) {
                                OP1button3D(size: size, buttonName: "play.fill", buttonColor: .white.opacity(0))
                            }
                            
                            Button(action: {model.musicPlayer.pause()}) {
                                OP1button3D(size: size, buttonName: "pause.fill", buttonColor: .white.opacity(0))
                            }
                            
                            Button(action: {model.forward()}) {
                                OP1button3D(size: size, buttonName: "forward.fill", buttonColor: .white.opacity(0))
                            }
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                OP1button3D(size: size, buttonName: "", buttonColor: .op1Blue)
                            }
                            
                            Button(action: {}) {
                                OP1button3D(size: size, buttonName: "", buttonColor: .op1Green)
                            }
                            
                            Button(action: {}) {
                                OP1button3D(size: size, buttonName: "", buttonColor: .op1BG2)
                            }
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                OP1button3D(size: size, buttonName: "", buttonColor: .op1Orange)
                            }
                        }
                    }
                    
                    ///.padding()
                }
                .frame(width: geometry.size.width / 1.2)
            }
        }
        .onAppear(){
            
        }
    }
}

struct OP1button2D: View {
    var body: some View{
        ZStack{
            Circle()
                ///.frame(width: geometry.size.width / 6, height: geometry.size.width / 6)
                .foregroundColor(.op1BG1)
                .shadow(color: .black.opacity(0.3), radius: 6, x: 6, y: 6)
                .shadow(color: .white, radius: 6, x: -6, y: -6)
                
            Image(systemName: "play.fill")
                .font(.title)
                .foregroundColor(.gray)
        }
        
        ZStack{
            
            Circle()
                ///.frame(width: geometry.size.width / 6, height: geometry.size.width / 6)
                .foregroundColor(.op1Blue)
                .shadow(color: .black.opacity(0.3), radius: 12, x: 12, y: 12)
                .shadow(color: .white, radius: 12, x: -12, y: -12)
        }
    }
}

struct OP1button3D: View {
    var size: CGFloat
    var buttonName: String
    var buttonColor: Color
    
    var body: some View{
        ZStack{
            Image("op1_button_1")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .shadow(radius: 4)
            
            Circle()
                .foregroundColor(buttonColor)
                .frame(width: size-32, height: size-32)
                .blur(radius: 2)
            
            Image(systemName: buttonName)
                .scaledToFit()
                .font(.title)
                .foregroundColor(.gray)
            
            
        }
        .padding()
    }
}
