//
//  LoaderView.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import SwiftUI

struct LoaderView: View  {
    
    @State private var degree: Double = 270.0
    @State private var duration = 0.7
    let radius: CGFloat = 20.0
    @State var ballsStyle = true
    @State var theme: Theme
    
    var body: some View {
        
        ZStack {
            
            theme.mainBGColor.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image("earth")
                    .resizable()
                    .scaledToFit()
                    .background(Color.clear)
                    .clipShape(Circle())
                    .opacity(1.0)
                    .shadow(color: Color.blue, radius: 10)
                    .animation(Animation.easeIn(duration: duration * 1.5).repeatForever(autoreverses: true), value: degree)
                    .frame(width: 3.67 * moonSpinnerSize,
                           height: 3.67 * moonSpinnerSize)
                    .rotationEffect(Angle(degrees: Double(degree)))
                    .animation(Animation.linear(duration: duration).repeatForever(autoreverses: false), value: degree)
                    .overlay(
                        CircularLoaderView(theme: theme)
                            .rotationEffect(Angle(degrees: degree))
                    )
                    .allowsHitTesting(ballsStyle)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear{
                        degree = 270.0 + 360.0
                        duration = 1.0
                    }
                
                Spacer().frame(height: 30)
                
                Text(LocalizedString.loadingText)
                    .font(Font.system(size: 24, weight: .medium))
                    .lineLimit(1)
                
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}


#Preview {
    LoaderView(theme: ThemeService.shared.selectedTheme)
}

struct LoaderViewModifier: ViewModifier {
    
    @Binding var isLoading: Bool
    @State var theme: Theme
    
    func body(content: Content) -> some View {
        
        ZStack {
            content
                .blur(radius: isLoading ? 3.0 : 0.0)
                .allowsHitTesting(!isLoading)
                .overlay(
                    ZStack {
                        if isLoading {
                            LoaderView(theme: theme)
                                .opacity(1.0)
                                .animation(.easeInOut(duration: 0.3), value: isLoading)
                            
                        } else {
                            EmptyView()
                        }
                    }
                        .edgesIgnoringSafeArea(.all)
                        .allowsHitTesting(false)
                    
                )
        }
    }
}

extension View {
    
    func loaderView(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoaderViewModifier(isLoading: isLoading,
                                         theme: ThemeService.shared.selectedTheme))
    }
    
    
}
