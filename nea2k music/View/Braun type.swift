//
//  Braun type.swift
//  nea2k music
//
//  Created by Yohey Kuwabara on 2022/03/01.
//

import SwiftUI

struct Braun_type: View {
    @ObservedObject var model: playerModel = playerModel()
    @State var buttonSpacing: CGFloat = 2
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                let circleSize = geometry.size.width/1.2
                Circle()
                .frame(width: circleSize, height: circleSize)
            
            
                let buttonWidth = geometry.size.width/6
                HStack(spacing: buttonSpacing){
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: buttonWidth, height: buttonWidth)
                        .foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: buttonWidth, height: buttonWidth)
                        .foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: buttonWidth, height: buttonWidth)
                        .foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: buttonWidth, height: buttonWidth)
                        .foregroundColor(.gray)
                }
                ///.offset(x: buttonWidth-3*buttonSpacing)
                
            }
            .offset(x: geometry.size.width/2)
            .padding()
        }
        
        .background(Color.iPod1stBG)
    }
}

struct Braun_type_Previews: PreviewProvider {
    static var previews: some View {
        Braun_type()
    }
}
