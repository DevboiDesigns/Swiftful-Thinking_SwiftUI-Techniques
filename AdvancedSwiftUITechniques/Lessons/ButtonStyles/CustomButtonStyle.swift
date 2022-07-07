//
//  CustomButtonStyle.swift
//  AdvancedSwiftUITechniques
//
//  Created by Christopher Hicks on 5/30/22.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1)
        
            // Custom highlight on opacity
            .opacity(configuration.isPressed ? 0.8 : 1)
//            .brightness(configuration.isPressed ? 0.5 : 0)
    }
}

extension View {
    
    func pressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
//        self.buttonStyle(PressableButtonStyle())
    }
}

struct CustomButtonStyle: View {
    var body: some View {
        Button {
            //
        } label: {
            Text("Click Me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 10)
        }
        .pressableStyle()
        //.buttonStyle(PressableButtonStyle())
        .padding()
    }
}

struct CustomButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonStyle()
    }
}
