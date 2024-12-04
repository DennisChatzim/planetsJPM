//
//  ResidentsDetailsView.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import SwiftUI

struct ResidentsDetailsView: View {
    
    @EnvironmentObject var themeService: ThemeService
    @ObservedObject var model: ResidentsDetailsViewModel
    var planetName: String
    
    var cellHeight: CGFloat = 44.0
    var horizontalPadding: CGFloat = 16.0
    @State var navigateToResidents = false
    
    var body: some View {
        
        ZStack {
            
            themeService.selectedTheme.mainBGColor
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                ForEach(model.residents) { resident in
                    
                    allResidentFields(resident: resident)
                    
                }
             
                Spacer().frame(height: 150)

            }
            
        }
        .loaderView(isLoading: $model.isLoading)
        .navigationTitle(myTitle())
        
    }
    
    func myTitle() -> String {
        return planetName + " (\(model.residentsUrls.count) residents)"
    }
    
    func allResidentFields(resident: ResidentDTO) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Spacer().frame(height: 10)

            RoundedRectangle(cornerRadius: 2)
                .fill(themeService.selectedTheme.mainBGColor2)
                .frame(height: 4)
                .padding(.horizontal, 16)

            Spacer().frame(height: 10)

            // Avoid showing views with empty or null String values !
            
            if let name = resident.name {
                
                HStack {

                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.blue)
                        .frame(height: 6)
                        .padding(.leading, 16)

                    Text(name)
                        .font(.headline)
                        .foregroundColor(themeService.selectedTheme.mainTextColour)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .padding(.horizontal, 5)
                        .minimumScaleFactor(1.0)
                        .fixedSize()

                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.blue)
                        .frame(height: 6)
                        .padding(.trailing, 16)

                }

                if let name = resident.name {
                    ReusableViews.valuesCell(title: LocalizedString.name,
                                    theme: themeService.selectedTheme,
                                    value: name)
                }
                
            }
            
            if let height = resident.height {
                ReusableViews.valuesCell(title: LocalizedString.height,
                                theme: themeService.selectedTheme,
                                value: height)
            }
            
            if let mass = resident.mass {
                ReusableViews.valuesCell(title: LocalizedString.mass,
                                theme: themeService.selectedTheme,
                                value: mass)
            }
            
            if let hairColor = resident.hairColor {
                ReusableViews.valuesCell(title: LocalizedString.hairColor,
                                theme: themeService.selectedTheme,
                                value: hairColor)
            }
            
            if let skinColor = resident.skinColor {
                ReusableViews.valuesCell(title: LocalizedString.skinColor,
                                theme: themeService.selectedTheme,
                                value: skinColor)
            }
            
            if let eyeColor = resident.eyeColor {
                ReusableViews.valuesCell(title: LocalizedString.eyeColor,
                                theme: themeService.selectedTheme,
                                value: eyeColor)
            }
            
            if let birthYear = resident.birthYear {
                ReusableViews.valuesCell(title: LocalizedString.birthYear,
                                theme: themeService.selectedTheme,
                                value: birthYear)
            }
            
            if let gender = resident.gender {
                ReusableViews.valuesCell(title: LocalizedString.gender,
                                theme: themeService.selectedTheme,
                                value: gender)
            }
            
            if let homeworld = resident.homeworld?.absoluteString {
                ReusableViews.valuesCell(title: LocalizedString.homeworld,
                                theme: themeService.selectedTheme,
                                value: homeworld)
            }
            
        }
        .padding(.horizontal, 5)

    }

}
