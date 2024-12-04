//
//  ResidentDTO.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//
import Foundation

import Foundation

struct ResidentDTO: Decodable, Identifiable {
    
    var id: URL { url } // Use `url` as the unique identifier

    var name: String?
    var height: String?
    var mass: String?
    var hairColor: String?
    var skinColor: String?
    var eyeColor: String?
    var birthYear: String?
    var gender: String?
    var homeworld: URL?
    var films: [URL]?
    var species: [URL]?
    var vehicles: [URL]?
    var starships: [URL]?
    var created: String?
    var edited: String?
    var url: URL

    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
        case films
        case species
        case vehicles
        case starships
        case created
        case edited
        case url
    }

}
