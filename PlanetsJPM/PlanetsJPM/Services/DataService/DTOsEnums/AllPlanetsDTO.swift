//
//  AllPlanetsDTO.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

struct AllPlanetsDTO: Codable {
    
    let count: Int?
    let next: String?
    var results: [PlanetDTO] = []
    // let previous: String? // Is always received as "null" and it never used -> Suggestion: Remove it from server response

    enum CodingKeys: String, CodingKey {
        case count
        case next
        case results
    }
    
}
