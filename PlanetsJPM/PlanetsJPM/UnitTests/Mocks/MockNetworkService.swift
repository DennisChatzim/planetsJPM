//
//  MockNetworkService.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import Foundation

class MockNetworkService: NetworkServiceProtocol {
      
    var successResult: AllPlanetsDTO?
    var error: Error?
    
    init(successResult: AllPlanetsDTO?,
         error: Error? = nil) {
        self.successResult = successResult
        self.error = error
    }
    
    func request<T: Decodable>(endpoint: APIEndpoint?,
                               endpointUrlString: String?,
                               body: Data? = nil) async throws -> T {
        
        if let error = error {
            
            throw error
            
        } else if let planets = successResult as? T {
            
            return planets
            
        } else {
            
            throw NSError(domain: "", code: -1, userInfo: [:])
            
        }
        
    }
    
}
