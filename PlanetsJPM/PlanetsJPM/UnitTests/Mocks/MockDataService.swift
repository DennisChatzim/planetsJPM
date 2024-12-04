//
//  Untitled.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import Combine
import Foundation

class MockDataService: DataServiceProtocol {

    var latestPlanets = CurrentValueSubject<AllPlanetsDTO?, Never>(nil)
    var bag: DisposeBagForCombine = []

    func saveToCache(data: AllPlanetsDTO?) {
        
        do {
            let encoder = JSONEncoder()
            let itemsData = try encoder.encode(data)
            UserDefaults.standard.set(itemsData, forKey: DataService.planetsStoreKey)
            UserDefaults.standard.synchronize()
        } catch {
            debugPrint("ERROR encoding latestPlanets?")
        }
        
    }
    
    func loadPlanetsFromCache() {
        
        guard let planetsData = UserDefaults.standard.data(forKey: DataService.planetsStoreKey) else {
            debugPrint("Warning: No AllPlanetsDTO data stored yet?")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let planetsDecoded = try decoder.decode(AllPlanetsDTO.self, from: planetsData)
            latestPlanets.send(planetsDecoded)
        } catch DecodingError.dataCorrupted(let context) {
            debugPrint("Decoding planets error: \(context.debugDescription)")
        } catch DecodingError.keyNotFound(let key, let context) {
            debugPrint("Decoding planets error: \(key.stringValue) was not found, \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            debugPrint("Decoding planets error: \(type) was expected, \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            debugPrint("Decoding planets error: no value was found for \(type), \(context.debugDescription)")
        } catch {
            print("Decoding planets error: Not known error = \(error)")
        }
        
    }
    
    var mockPlanets: AllPlanetsDTO?
    var mockResident: ResidentDTO?
    var shouldReturnError = false
        
    init() {
        loadPlanetsFromCache()
        
        latestPlanets
            .dropFirst(1)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newPlanets in
                self?.saveToCache(data: newPlanets)
            })
            .store(in: &bag)
    }

    func getLatestPlanets() async throws {
        if shouldReturnError {
            throw NetworkError.decodingError
        }
        latestPlanets.send(mockPlanets)
    }
    
    func getResidentDetails(residentUrl: String) async throws -> ResidentDTO {
        if let mockResident = mockResident {
            return mockResident
        } else {
            if shouldReturnError {
                throw NetworkError.decodingError
            } else {
                throw NetworkError.requestFailed
            }
        }
    }
    
}
