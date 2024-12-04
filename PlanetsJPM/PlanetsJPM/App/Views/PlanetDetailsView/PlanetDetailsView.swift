//
//  PlanetDetailsView.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import SwiftUI

struct PlanetDetailsView: View {
    
    @ObservedObject var themeService: ThemeService = ThemeService.shared
    
    var planet: PlanetDTO
    var cellHeight: CGFloat = 44.0
    var horizontalPadding: CGFloat = 16.0
    @State var navigateToResidents = false
    
    var body: some View {
        
        ZStack {
            
            themeService.selectedTheme.mainBGColor
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                allPlanetFields
                
            }
            
        }
        .navigationTitle(planet.name ?? "Unknown name?")
        
    }
    
    var allPlanetFields: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Spacer().frame(height: 20)
            
            // Avoid showing views with empty or null String values !
            
            if let rotation_period = planet.rotation_period {
                ReusableViews.valuesCell(title: LocalizedString.rotation_period,
                                theme: themeService.selectedTheme,
                                value: rotation_period)
            }
            
            if let orbital_period = planet.orbital_period {
                ReusableViews.valuesCell(title: LocalizedString.orbital_period,
                                theme: themeService.selectedTheme,
                                value: orbital_period)
            }
            
            if let diameter = planet.diameter {
                ReusableViews.valuesCell(title: LocalizedString.diameter,
                                theme: themeService.selectedTheme,
                                value: diameter)
            }
            
            if let climate = planet.climate {
                ReusableViews.valuesCell(title: LocalizedString.climate,
                                theme: themeService.selectedTheme,
                                value: climate)
            }
            
            if let gravity = planet.gravity {
                ReusableViews.valuesCell(title: LocalizedString.gravity,
                                theme: themeService.selectedTheme,
                                value: gravity)
            }
            
            if let terrain = planet.terrain {
                ReusableViews.valuesCell(title: LocalizedString.terrain,
                                theme: themeService.selectedTheme,
                                value: terrain)
            }
            
            if let surface_water = planet.surface_water {
                ReusableViews.valuesCell(title: LocalizedString.surface_water,
                                theme: themeService.selectedTheme,
                                value: surface_water)
            }
            
            if let population = planet.population {
                ReusableViews.valuesCell(title: LocalizedString.population,
                                theme: themeService.selectedTheme,
                                value: population)
            }
            
            VStack(spacing: 0) {
                
                ReusableViews.valuesCell(title: LocalizedString.numberOfResidents,
                                theme: themeService.selectedTheme,
                                addArrowRight: true,
                                value: "\((planet.residents ?? []).count)")
                .bounceTap(theme: themeService.selectedTheme) { // custom tap modifier to aimate with scale and border ANY SwiftUI tappable view
                    if !(planet.residents ?? []).isEmpty {
                        navigateToResidents = true
                    }
                }
                
                NavigationLink(destination: ResidentsDetailsView(themeService: themeService,
                                                                 model: ResidentsDetailsViewModel(residentsUrls: planet.residents ?? [], dataService: DataService.shared),
                                                                 planetName: planet.name ?? "Unknown planet name?"),
                               isActive: $navigateToResidents,
                               label: { EmptyView() })
                
                
            }
            .onAppear {
                navigateToResidents = false
            }
            
            ReusableViews.valuesCell(title: LocalizedString.numberOfFilms,
                            theme: themeService.selectedTheme,
                            value: "\((planet.films ?? []).count)")
            
            if planet.created != nil {
                ReusableViews.valuesCell(title: LocalizedString.createdDate,
                                theme: themeService.selectedTheme,
                                value: planet.createdDateFormated())
            }
            
            if planet.edited != nil {
                ReusableViews.valuesCell(title: LocalizedString.editedDate,
                                theme: themeService.selectedTheme,
                                value: planet.editedDateFormated())
            }
            
            Spacer().frame(height: 200)
            
            Spacer()
            
        }
        .padding(.bottom, 150)
        .padding(.horizontal, 5)

    }
    
}
