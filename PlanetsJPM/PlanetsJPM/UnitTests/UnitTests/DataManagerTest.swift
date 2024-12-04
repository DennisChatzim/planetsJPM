//
//  DataManagerTest.swift
//  PlanetsJPMTests
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import XCTest
@testable import PlanetsJPM


// DataService:
//Cache Saving and Loading:
   // Test that data is saved to UserDefaults when saveToCache is called.
   // Test that data is loaded correctly from UserDefaults.
// --
//Planets Retrieval:
   //Test that the getLatestPlanets() method correctly retrieves and sets the data.
   //Edge Cases and Errors
   //Test behavior when UserDefaults contains corrupted data.
   //Test network failures in getLatestPlanets().
                                            
final class DataServiceTests: XCTestCase {
    
    var dataService: DataService!
    var mockNetworkService: MockNetworkService!
    var mockUserDefaults: UserDefaults!

    override func setUp() {
        super.setUp()

        // Mock UserDefaults
        mockUserDefaults = UserDefaults.standard
        UserDefaults.standard.set(nil, forKey: DataService.planetsStoreKey)

        // Mock NetworkService
        mockNetworkService = MockNetworkService.init(successResult: nil, error: nil)
        
        // Create DataService instance with mocks
        dataService = DataService(networkService: mockNetworkService)
    }

    override func tearDown() {
        mockUserDefaults = nil
        mockNetworkService = nil
        dataService = nil
        UserDefaults.standard.set(nil, forKey: DataService.planetsStoreKey)

        super.tearDown()
    }

    // Test saving to cache
    func testSaveToCache() {
                
        let mockPlanets = DataServiceTests.getMockPlanets()
        dataService.latestPlanets.send(mockPlanets)
        
        let expectation = self.expectation(description: "Wait for async operation")

        // 2. Perform the async task (e.g., network request or other async operations)
        DispatchQueue.global().async {
            // Simulate a delay (this could be your async task)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // 3. Fulfill the expectation when the task is completed
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.5)
        
        let storedData = mockUserDefaults.data(forKey: DataService.planetsStoreKey)
        
        XCTAssertNotNil(storedData, "Data should be saved to UserDefaults")
        
        let decoder = JSONDecoder()
        let decodedPlanets = try? decoder.decode(AllPlanetsDTO.self, from: storedData!)
        
        XCTAssertEqual(decodedPlanets, mockPlanets, "Decoded data should match the original data")
    }
    
    // Test loading from cache
    func testLoadFromCache() {
        
        let mockPlanets = DataServiceTests.getMockPlanets()
        let encoder = JSONEncoder()
        let data = try! encoder.encode(mockPlanets)
        mockUserDefaults.set(data, forKey: DataService.planetsStoreKey)
        
        let expectation = self.expectation(description: "Wait for async operation")
        wait(for: [expectation], timeout: 1.5)

        dataService.loadPlanetsFromCache()
        
        XCTAssertEqual(dataService.latestPlanets.value, mockPlanets, "Data should be loaded correctly from cache")
    }
    
    // Test loading from cache with corrupted data
    func testLoadFromCacheWithCorruptedData() {
        
        mockUserDefaults.set(Data("CorruptedData".utf8), forKey: DataService.planetsStoreKey)
        dataService.loadPlanetsFromCache()
        
        XCTAssertNil(dataService.latestPlanets.value, "latestPlanets should be nil when data is corrupted")
    }
    
    // Test getLatestPlanets success
    func testGetLatestPlanetsSuccess() async throws {
        
        let mockPlanets = DataServiceTests.getMockPlanets()
        dataService.latestPlanets.send(nil)
        
        mockNetworkService.successResult = mockPlanets
        mockNetworkService.error = nil
        
        dataService.myNetworkService = mockNetworkService
        try await dataService.getLatestPlanets()
        
        XCTAssertEqual(dataService.latestPlanets.value, mockPlanets, "Data should be set correctly after successful network request")
    }
    
    // Test getLatestPlanets failure
    func testGetLatestPlanetsFailure() async throws {

        let error = NSError(domain: "NetworkError", code: -1, userInfo: nil)
        mockNetworkService.successResult = nil
        mockNetworkService.error = error

        do {
            try await dataService.getLatestPlanets()
            XCTFail("Error should be thrown when network request fails")
        } catch {
            XCTAssertNotNil(error, "Error should not be nil")
        }
    }
    
    static func getMockPlanets() -> AllPlanetsDTO? {
        
        let planet1 = PlanetDTO(name: "Tatooine",
                                rotation_period: "rotation_period1",
                                orbital_period: "orbital_period1",
                                diameter: "diameter1",
                                climate: "climate1",
                                gravity: "gravity1",
                                terrain: "terrain1",
                                surface_water: "surface_water1",
                                population: "population1",
                                residents: ["residents1"],
                                films: ["film1", "film2"],
                                created: "created1",
                                edited: "edited1",
                                url: "url1")
        
        let planet2 = PlanetDTO(name: "Alderaan",
                                rotation_period: "rotation_period2",
                                orbital_period: "orbital_period2",
                                diameter: "diameter2",
                                climate: "climate2",
                                gravity: "gravity2",
                                terrain: "terrain2",
                                surface_water: "surface_water2",
                                population: "population2",
                                residents: ["residents2"],
                                films: ["film2", "film22"],
                                created: "created2",
                                edited: "edited2",
                                url: "url2")
        
        let planet3 = PlanetDTO(name: "Dagobah",
                                rotation_period: "rotation_period3",
                                orbital_period: "orbital_period3",
                                diameter: "diameter3",
                                climate: "climate3",
                                gravity: "gravity3",
                                terrain: "terrain3",
                                surface_water: "surface_water3",
                                population: "population3",
                                residents: ["residents3"],
                                films: ["film33", "film33"],
                                created: "created1",
                                edited: "edited1",
                                url: "url")
        
        let mockPlanets = AllPlanetsDTO(count: 3,
                                        next: "",
                                        results: [planet1, planet2, planet3])
        
        return mockPlanets
    }
}

