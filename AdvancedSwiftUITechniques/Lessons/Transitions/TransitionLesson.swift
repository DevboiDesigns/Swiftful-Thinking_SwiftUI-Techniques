//
//  TransitionLesson.swift
//  AdvancedSwiftUITechniques
//
//  Created by Christopher Hicks on 5/30/22.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
        // Rotate on and off screen from bottom corner
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    static var rotating: Self {
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0))
        // Add scale effect
       // .combined(with: .scale.animation(.easeInOut))
    }
    
    static func rotating(rotation: Double) -> Self {
        modifier(
            active: RotateViewModifier(rotation: rotation),
            identity: RotateViewModifier(rotation: 0))
        // Add scale effect
       // .combined(with: .scale.animation(.easeInOut))
    }
    
    // Rotates ON screen & slides OFF via leading
    static var rotateOn: Self {
        asymmetric(insertion: .rotating, removal: .move(edge: .leading))
    }
}

struct TransitionLesson: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
             
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                // Rotates ON screen & slides OFF via leading
                    .transition(.rotateOn)
                // Spirals on & screen
//                    .transition(.rotating(rotation: 1080))
                // 1st Custom Transition
                    .transition(AnyTransition.rotating)
                // Scale in & out to nothing 
//                    .transition(AnyTransition.scale.animation(.easeInOut))
                // Slides in & out from leading edge
//                    .transition(.move(edge: .leading))
                
            }
            
            Spacer()
            
            Text("Click Me!")
                .mainButtonFormat()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

struct TransitionLesson_Previews: PreviewProvider {
    static var previews: some View {
        TransitionLesson()
    }
}
