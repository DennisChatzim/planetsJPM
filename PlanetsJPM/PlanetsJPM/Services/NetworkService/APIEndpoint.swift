//
//  APIEndpoint.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import Foundation

enum APIEndpoint {
        
    case getPlanets
    
    var path: String {
        switch self {
        case .getPlanets:
            return "/api/planets/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPlanets:
            return HTTPMethod.GET
        }
    }
    
    var url: URL? {
        return URL(string: NetworkConfig.baseURL + path)
    }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}
