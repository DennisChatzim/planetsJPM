//
//  NetworkConfig.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import Foundation

struct NetworkConfig {
    
    static var baseURL: String {
        if let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String {
            return baseURL
        } else {
            fatalError("BaseURL not found in Info.plist")
        }
    }
    
}
