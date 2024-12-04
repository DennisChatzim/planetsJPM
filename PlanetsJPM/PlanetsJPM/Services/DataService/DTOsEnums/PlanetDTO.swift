//
//  PlanetDTO.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//


import Foundation

// Codable: We need it because we need to extract and decode it from server http response data
// Hashable: We need it because "ForEach(" in SwiftUI needs it

struct PlanetDTO: Codable, Hashable {
    
    let name, rotation_period, orbital_period, diameter: String?
    let climate, gravity, terrain, surface_water: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?
    
    init(name: String?,
         rotation_period: String?,
         orbital_period: String?,
         diameter: String?,
         climate: String?,
         gravity: String?,
         terrain: String?,
         surface_water: String?,
         population: String?,
         residents: [String]?,
         films: [String]?,
         created: String?,
         edited: String?,
         url: String?) {
        
        self.name = name
        self.rotation_period = rotation_period
        self.orbital_period = orbital_period
        self.diameter = diameter
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.surface_water = surface_water
        self.population = population
        self.residents = residents
        self.films = films
        self.created = created
        self.edited = edited
        self.url = url
    }
    
    // We need Hashable because "ForEach(" needs it
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(rotation_period)
        hasher.combine(orbital_period)
        hasher.combine(diameter)
        hasher.combine(climate)
        hasher.combine(gravity)
        hasher.combine(terrain)
        hasher.combine(surface_water)
        hasher.combine(population)
        hasher.combine(residents)
        hasher.combine(films)
        hasher.combine(created)
        hasher.combine(edited)
        hasher.combine(url)
    }

    enum CodingKeys: String, CodingKey {
        case name
        case rotation_period
        case orbital_period
        case diameter, climate, gravity, terrain
        case surface_water
        case population, residents, films, created, edited, url
    }
    
    func createdDateFormated() -> String {
        guard let created = created else { return "" }
        if let dateObj = dateFormatter.date(from: created) {
            return dateReadableFormatter.string(from: dateObj)
        } else {
            return ""
        }
    }
    
    func editedDateFormated() -> String {
        guard let edited = edited else { return "" }
        if let dateObj = dateFormatter.date(from: edited) {
            return dateReadableFormatter.string(from: dateObj)
        } else {
            return ""
        }
    }
    
    // This is the DateFormatter which should be used to extract the date object from the string that we receive from server, example:  "created": "2014-12-09T13:50:49.641000Z",
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }
    
    // This is the DateFormatter which should be used to show the date to the user
    var dateReadableFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        return dateFormatter
    }
    
}
