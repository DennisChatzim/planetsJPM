//
//  AllPlanetsDTO.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

struct AllPlanetsDTO: Codable, Equatable {
    
    let count: Int?
    let next: String?
    var results: [PlanetDTO] = []
    // let previous: String? // Is always received as "null" and it never used -> Suggestion: Remove it from server response

    enum CodingKeys: String, CodingKey {
        case count
        case next
        case results
    }
    
    static func == (lhs: AllPlanetsDTO, rhs: AllPlanetsDTO) -> Bool {
        guard lhs.results.count == rhs.results.count else { return false }
        
        for index1 in 0..<lhs.results.count {
            for index2 in 0..<rhs.results.count {
                let planet1 = lhs.results[index1]
                let planet2 = rhs.results[index2]
                if planet1.name != planet2.name { // Here we should use id if existed
                    return false
                }
            }
        }

        return true
    }
    
}
