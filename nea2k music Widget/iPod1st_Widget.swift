//
//  iPod1st_Widget.swift
//  nea2k music
//
//  Created by Yohey Kuwabara on 2022/11/01.
//

import SwiftUI

struct iPod1st_Widget: View {
    var songTitle: String
    var artistName: String
    var isPlaying: Bool
    var batterySymbol: String
    
    var body: some View{
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
                            if isPlaying{
                                Image(systemName: "play.fill")
                                    .foregroundColor(.chicagoText)
                            }else{
                                Image(systemName: "pause.fill")
                                    .foregroundColor(.chicagoText)
                            }
                            Spacer()
                            Image(systemName: batterySymbol)
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
                    Text(songTitle)
                        .font(.custom("Chicago", size: 28))
                        .foregroundColor(.chicagoText)
                    Text(artistName)
                        .font(.custom("Chicago", size: 22))
                        .foregroundColor(.chicagoText)
                    Spacer()
                        
                }
                .padding()
            }
            
        }
    }
}
