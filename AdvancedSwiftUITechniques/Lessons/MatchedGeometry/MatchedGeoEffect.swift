//
//  MatchedGeoEffect.swift
//  AdvancedSwiftUITechniques
//
//  Created by Christopher Hicks on 5/30/22.
//

import SwiftUI

struct MatchedGeoEffect: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25)
                // Best with actual shapes Circle, Capsule etc
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
                
            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeoEffect_Previews: PreviewProvider {
    static var previews: some View {
        MachedGeoEffectTwo()
    }
}


struct MachedGeoEffectTwo: View {
    
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespaceTwo
    
    var body: some View {
        HStack {
            ForEach(categories, id:\.self) { category in
                ZStack {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "square", in: namespaceTwo)
                        
                    }
                    Text(category)
                        .foregroundColor(selected == category ? .white : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}
