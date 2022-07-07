//
//  CustomViewModifiers.swift
//  AdvancedSwiftUITechniques
//
//  Created by Christopher Hicks on 5/29/22.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    var backgroundColor: Color
    var frameSize: CGFloat
    var font: Font
    
    init(backgroundColor: Color, frameSize: CGFloat = 55, font: Font = .headline) {
        self.backgroundColor = backgroundColor
        self.frameSize = frameSize
        self.font = font
    }
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: frameSize)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    func mainButtonFormat(backgroundColor: Color = .blue, frameSize: CGFloat = 55, font: Font = .headline) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor, frameSize: frameSize, font: font))
    }
}

struct CustomViewModifiers: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .modifier(DefaultButtonViewModifier(backgroundColor: .blue, font: .title))
            
            Text("Whats up")
                .mainButtonFormat(backgroundColor: .red, frameSize: 100)
            
            Text("Omboi")
                .mainButtonFormat(backgroundColor: .black)
        }
    }
}

struct CustomViewModifiers_Previews: PreviewProvider {
    static var previews: some View {
        CustomViewModifiers()
    }
}
