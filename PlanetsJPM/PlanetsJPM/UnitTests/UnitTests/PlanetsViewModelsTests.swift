//
//  PlanetsViewModelsTests.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import Combine
import Foundation
import XCTest
@testable import PlanetsJPM

final class PlanetsViewModelTests: XCTestCase {

    var viewModel: PlanetsViewModel!
    var mockDataService: MockDataService!
    
    override func setUp() {
        super.setUp()
        mockDataService = MockDataService()
        viewModel = PlanetsViewModel(dataService: mockDataService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func test_initialState() {
        XCTAssertNil(viewModel.currentPlanets, "Current planets should initially be nil.")
        XCTAssertFalse(viewModel.isLoading, "isLoading should initially be false.")
        XCTAssertFalse(viewModel.showAlert, "showAlert should initially be false.")
        XCTAssertEqual(viewModel.errorMessage, "", "Error message should initially be empty.")
    }
    
    func test_getLatestPlanets_success() async {

        // Arrange
        let mockPlanets = DataServiceTests.getMockPlanets()
        mockDataService.latestPlanets.send(mockPlanets)
        
        // Act
        viewModel.getLatestPlanets(withDemoDelay: 0.0)
        
        // Assert
        //XCTAssertEqual(viewModel.currentPlanets, mockPlanets, "currentPlanets should be updated with the mock data.")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching planets.")
        XCTAssertFalse(viewModel.showAlert, "showAlert should not be shown on success.")
    }
    
    func test_getLatestPlanets_failure() async {
        
        // Arrange
        mockDataService.shouldReturnError = true
        
        // Act
        viewModel.getLatestPlanets(withDemoDelay: 0.0)
        
        let expectation = self.expectation(description: "Wait for async operation")

        // 2. Perform the async task (e.g., network request or other async operations)
        DispatchQueue.global().async {
            // Simulate a delay (this could be your async task)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // 3. Fulfill the expectation when the task is completed
                expectation.fulfill()
            }
        }
        
        await fulfillment(of: [expectation], timeout: 1.5, enforceOrder: true)
                
        // Assert
        XCTAssertTrue(viewModel.isLoading == false, "isLoading should be false after an error occurs.")
        
        XCTAssertTrue(viewModel.showAlert, "showAlert should be shown when an error occurs.")
        XCTAssertNotEqual(viewModel.errorMessage, "", "Error message should match the mock error.")
    }
    
    func test_showError_updatesProperties() {
        // Act
        viewModel.showError(msg: "Test error")
        
        // Assert
        XCTAssertTrue(viewModel.showAlert, "showAlert should be true after calling showError.")
        XCTAssertEqual(viewModel.errorMessage, "Test error", "Error message should be updated.")
    }
}
