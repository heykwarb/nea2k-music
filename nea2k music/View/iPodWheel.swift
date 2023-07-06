//
//  iPodWheel.swift
//  nea2k music
//
//  Created by Yohey Kuwabara on 2022/04/06.
//

import SwiftUI

struct iPodWheel: View {
    @ObservedObject var model: playerModel ///= playerModel()
    @State var selectedButton = 0
    @State var wheelRadius: CGFloat = 160
    @State var wheelButtonSize: CGFloat = 120
    @State var wheelCenterSize: CGFloat = 100
    
    @State var tapped = 0
    
        ///let lightHaptic = hapti
    
    var body: some View{
        VStack{
            ZStack{
                Image("clickWheel_menu")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 2*wheelRadius, height: 2*wheelRadius)
                    .shadow(radius: 2)
                    ///.offset(y: (wheelRadius-wheelButtonSize/2))
                Image("clickWheel_play")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 2*wheelRadius, height: 2*wheelRadius)
                    .shadow(radius: 2)
                    ///.offset(y: -(wheelRadius-wheelButtonSize/2))
                Image("clickWheel_backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 2*wheelRadius, height: 2*wheelRadius)
                    .shadow(radius: 2)
                    ///.offset(x: (wheelRadius-wheelButtonSize/2))
                Image("clickWheel_forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 2*wheelRadius, height: 2*wheelRadius)
                    .shadow(radius: 2)
                    ///.offset(x: -(wheelRadius-wheelButtonSize/2))
                Image("clickWheel_button")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 2*wheelRadius, height: 2*wheelRadius)
                    .shadow(radius: 2)
                
                
                //menu
                Button(action: {
                    model.showPicker.toggle()
                    print("menu")
                }) {
                    ZStack{
                        
                        
                        Circle()
                            .frame(width: wheelButtonSize, height: wheelButtonSize)
                            .opacity(0)
                        
                        Text("MENU")
                            .offset(y: (wheelCenterSize-wheelButtonSize)/2)
                    }
                }
                .offset(y: -(wheelRadius-wheelButtonSize/2))
                
                //play pause
                Button(action: {
                    model.playButton()
                    
                }) {
                    ZStack{
                        
                        
                        Circle()
                            .frame(width: wheelButtonSize, height: wheelButtonSize)
                            .opacity(0)
                        
                        HStack{
                            Image(systemName: "play.fill")
                            Text("/")
                            Image(systemName: "pause.fill")
                        }
                        .offset(y: -(wheelCenterSize-wheelButtonSize)/2)
                    }
                }
                .offset(y: wheelRadius-wheelButtonSize/2)
                
                //backward
                Button(action: {
                    model.backward()
                    
                }) {
                    ZStack{
                        
                        
                        Circle()
                            .frame(width: wheelButtonSize, height: wheelButtonSize)
                            .opacity(0)
                        
                        Image(systemName: "backward.fill")
                            .offset(x: (wheelCenterSize-wheelButtonSize)/2)
                    }
                }
                .offset(x: -(wheelRadius-wheelButtonSize/2))
                
                //forward
                Button(action: {
                    model.forward()
                    
                }) {
                    ZStack{
                        
                        
                        Circle()
                            .frame(width: wheelButtonSize, height: wheelButtonSize)
                            .opacity(0)
                        
                        Image(systemName: "forward.fill")
                            .offset(x: -(wheelCenterSize-wheelButtonSize)/2)
                    }
                }
                .offset(x: wheelRadius-wheelButtonSize/2)
                
                //center
                Button(action: {
                    
                }) {
                    ZStack{
                        
                    }
                }
            }
        }
    }
}

struct wheelArc: View{
    var body: some View{
        GeometryReader { geometry in
            Path() { path in
                path.move(to: CGPoint(x: geometry.size.width/2, y: geometry.size.height/2))
                        path.addArc(center: .init(x: geometry.size.width/2, y: geometry.size.height/2), radius: 150, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 270), clockwise: true)
            }
        }
        
    }
}


