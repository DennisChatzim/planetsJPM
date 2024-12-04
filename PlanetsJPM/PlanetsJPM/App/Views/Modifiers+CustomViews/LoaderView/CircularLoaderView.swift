//
//  CircularLoaderView.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import SwiftUI

public var moonSpinnerSize = 20.0

struct CircularLoaderView: View {
    
    @State var theme: Theme
    let animationDuration: Double = 1.0 // Duration for the spring movement
    
    let rotationSpeed: Double = 1.2 // Slower rotation speed for the entire view
    @State private var isAnimating = false
    @State private var rotationAngle: Double = 0 // For rotating the entire view
    
    var body: some View {
        ZStack {
            
            Image("moon")
                .resizable()
                .scaledToFit()
                .foregroundColor(theme.mainTextColour)
                .background(Color.clear)
                .clipShape(Circle())
                .shadow(color: Color.blue, radius: 4)
                .opacity(1.0)
                .frame(width: moonSpinnerSize, height: moonSpinnerSize)
                .offset(y: 120)
                .edgesIgnoringSafeArea(.all)
                .animation(
                    .easeInOut(duration: animationDuration)
                    .repeatForever(autoreverses: true), value: isAnimating
                )
            
        }
        .rotationEffect(Angle.degrees(rotationAngle))
        .animation(.linear(duration: 2 * rotationSpeed).repeatForever(autoreverses: false), value: rotationAngle)
        .onAppear {
            self.isAnimating.toggle()
            withAnimation {
                self.rotationAngle = -360
            }
        }
    }
    
}

//struct CircularLoaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularLoaderView(theme: ThemeService.shared.selectedTheme)
//    }
//}
//

#Preview {
    CircularLoaderView(theme: ThemeService.shared.selectedTheme)
}
