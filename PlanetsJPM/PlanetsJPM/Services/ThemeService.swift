//
//  ThemeService.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import SwiftUI

class ThemeService: ObservableObject, Codable, Equatable, Hashable {
    
    static let shared = ThemeService()
    
    @Published var isDarkThemeActive = false
    @Published var selectedTheme: Theme = .unknown
    
    var bordersColours: [Color] = [Color.blue,
                                  Color.yellow,
                                  Color.green,
                                  Color.yellow,
                                  Color.blue,
                                  Color.yellow]
    
    init() {
        $selectedTheme.map { $0 == .dark ? true : false }.assign(to: &$isDarkThemeActive)
    }
    
    func setThemeFromSystem(_ systemTheme: ColorScheme) {
                
        if selectedTheme == .unknown {
            if systemTheme == .dark {
                selectedTheme = .dark
            } else {
                selectedTheme = .light
            }
        } else {
            selectedTheme = systemTheme == .dark ? .dark : .light
        }
        
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(isDarkThemeActive)
        hasher.combine(selectedTheme)
    }
    
    static func == (lhs: ThemeService, rhs: ThemeService) -> Bool {
        return lhs.isDarkThemeActive == rhs.isDarkThemeActive && lhs.selectedTheme == rhs.selectedTheme
    }
    
    
    // Encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isDarkThemeActive, forKey: .isDarkThemeActive)
        try container.encode(selectedTheme.rawValue, forKey: .selectedTheme)
    }
    
    // Decoding
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isDarkThemeActive = try container.decode(Bool.self, forKey: .isDarkThemeActive)
        let selectedThemeString = try container.decode(String.self, forKey: .selectedTheme)
        self.selectedTheme = Theme(rawValue: selectedThemeString) ?? .dark
    }
    
    // Coding Keys
    enum CodingKeys: String, CodingKey {
        case isDarkThemeActive
        case selectedTheme
    }
    
}

enum Theme: String, CaseIterable {
    
    case light, dark, unknown
    
    var mainTextColour: Color {
        switch self {
        case .light: return Color.init(white: 0.0, opacity: 1.0)
        case .dark: return Color.init(white: 1.0, opacity: 1.0)
        case .unknown: return Color.init(white: 1.0, opacity: 1.0)
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .unknown: return .dark
        }
    }
    
    var mainBGColor: Color {
        switch self {
        case .light: return .white
        case .dark: return .black
        case .unknown: return .black
        }
    }

    var mainBGColor2: Color {
        switch self {
        case .light: return Color.init(white: 0.93)
        case .dark: return Color.init(white: 0.07)
        case .unknown: return Color.init(white: 0.07)
        }
    }
        
}
