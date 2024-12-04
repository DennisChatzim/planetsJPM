//
//  MainPlanetsView.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import SwiftUI

struct PlanetsView: View {
    
    @ObservedObject var themeService: ThemeService = ThemeService.shared
    @StateObject var model = PlanetsViewModel(dataService: DataService.shared)
    
    @State private var position: CGFloat = 0.0

    @State private var plantToShow: PlanetDTO?
    @State private var navigateToDetail = false

    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                GeometryReader { proxy in
                    
                    ScrollView {
                        
                        allPlanetsView(width: proxy.size.width)
                        
                    }
                    .refreshable(action:  {
                        tryLoadingData(withDemoDelay: 2.0)
                    })
                    .frame(width:  proxy.size.width) // On iPads we need to limit the width to 400, otheriwize it will take full width
                    
                }
                
            }
            .loaderView(isLoading: $model.isLoading)
            .preferredColorScheme(themeService.selectedTheme.colorScheme)
            .animation(.easeInOut(duration: 0.5), value: themeService.selectedTheme)
            .onAppear {
                if model.currentPlanets?.results.isEmpty ?? true {
                    tryLoadingData(withDemoDelay: 0.0)
                }
            }
            .navigationTitle(LocalizedString.appName)
            .navigationBarItems(trailing: themeButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(LocalizedString.errorNetworkAlertTitle,
               isPresented: $model.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(model.errorMessage)
        }
    }
    
    func tryLoadingData(withDemoDelay: Double) {
        model.getLatestPlanets(withDemoDelay: withDemoDelay)
    }
    
    @ViewBuilder // We use this for faster rendering and helping SwiftUI when the view contains multiple internal views !
    func allPlanetsView(width: CGFloat) -> some View {
        
        HStack {
            
            Spacer() // We use Spacers because the approach with VStack(alignment: center) doesn't work correctly
            // for keepng the scrollView in the middle of the screen on iPad screens
            
            LazyVStack(alignment: .center, spacing: 5) {
                
                ForEach(model.currentPlanets?.results ?? [], id: \.self) { planet in
                    
                    VStack {
                        
                        planetCellView(planet: planet)
                            .bounceTap(theme: themeService.selectedTheme) { // custom tap modifier to aimate with scale and border ANY SwiftUI tappable view
                                plantToShow = planet
                                navigateToDetail = true
                            }
                        
                        NavigationLink(destination: PlanetDetailsView(themeService: themeService,
                                                                      planet: plantToShow ?? planet),
                                       isActive: $navigateToDetail,
                                       label: { EmptyView() })
                        
                    }
                    
                }
            }
            .padding(.bottom, 150)
            .frame(maxWidth: min(500, width)) // On iPads we need to limit the width to 400, otheriwize it will take full width
            .onAppear {
                navigateToDetail = false
                plantToShow = nil
            }
            
            Spacer() // We use Spacers because the approach with VStack(alignment: center) doesn't work correctly
            // for keepng the scrollView in the middle of the screen on iPad screens
  
        }
        
    }
    
    func planetCellView(planet: PlanetDTO) -> some View {
        
        HStack {
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(planet.name ?? "Empty name?")
                    .font(Font.largeTitle)
                    .foregroundColor(themeService.selectedTheme.mainTextColour)
                    .lineLimit(2)
                
                Text("Residents: \(planet.residents?.count ?? 0), Films: \(planet.films?.count ?? 0)")
                    .font(Font.body)
                    .foregroundColor(themeService.selectedTheme.mainTextColour)
                    .lineLimit(2)
                
            }
            .padding()
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing, 15)
            
        }
        .colourfulBorder(colors: themeService.bordersColours)
        .padding(10)
        
    }
    
    // This button is used the toggle between Dark and Light theme
    var themeButton: some View {
        
        Button(action: {
            themeService.selectedTheme = themeService.selectedTheme == .dark ? .light : .dark
        }) {
            Image(systemName: themeService.selectedTheme == .dark ? "moon.fill" : "sun.max.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 22)
        }
        
    }
    
}

#Preview {
    PlanetsView()
}