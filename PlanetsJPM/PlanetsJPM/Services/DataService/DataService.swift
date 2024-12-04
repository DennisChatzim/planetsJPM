//
//  DataService.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//


import Foundation
import Combine

protocol DataServiceProtocol {
    var latestPlanets: CurrentValueSubject<AllPlanetsDTO?, Never> { get set }
    func saveToCache(data: AllPlanetsDTO?)
    func loadPlanetsFromCache()
    func getLatestPlanets() async throws
    func getResidentDetails(residentUrl: String) async throws -> ResidentDTO
}

class DataService: ObservableObject, DataServiceProtocol {
    
    static let shared = DataService(networkService: NetworkService.shared)
    
    var myNetworkService: NetworkServiceProtocol
    static var planetsStoreKey = "planetsStoreKey"
    var latestPlanets = CurrentValueSubject<AllPlanetsDTO?, Never>(nil)
    var bag: DisposeBagForCombine = []
    
    init(networkService: NetworkServiceProtocol) {
        
        myNetworkService = networkService
        
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
        
        do {
            let allPlanets: AllPlanetsDTO = try await myNetworkService.request(endpoint: APIEndpoint.getPlanets,
                                                                               endpointUrlString: nil,
                                                                               body: nil)
            // We let data to be set in background thread its okay.
            // We will use the main thread only in PlanetsViewModel in order to update UI of the PlanetsView
            self.latestPlanets.send(allPlanets)
        } catch {
            print("Error occured: \(error)")
            throw error
        }
        
    }
    
    func getResidentDetails(residentUrl: String) async throws -> ResidentDTO {
        
        do {
            
            let resident: ResidentDTO = try await myNetworkService.request(endpoint: nil,
                                                                           endpointUrlString: residentUrl,
                                                                           body: nil)
            return resident
            
        } catch {
            print("Error occured: \(error)")
            throw error
        }
        
    }
    
}

// MARK: Cache mechanism
extension DataService {
    
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
    
}
