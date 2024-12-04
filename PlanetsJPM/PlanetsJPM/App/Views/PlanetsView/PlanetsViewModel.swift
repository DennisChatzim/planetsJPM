//
//  PlanetsViewModel.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import Combine
import SwiftUI

class PlanetsViewModel: ObservableObject {
    
    let dataService: DataServiceProtocol
    @Published var currentPlanets: AllPlanetsDTO?
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String = ""
    
    init(dataService: DataServiceProtocol) {

        self.dataService = dataService

        // Whenever DataService gets new data automatically thanks to Combine they will be assigned to this model -> currentPlanets Published property
        self.dataService.latestPlanets
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentPlanets)
    }
    
    func getLatestPlanets(withDemoDelay: Double) {

        DispatchQueue.main.async { self.isLoading = true } // We need this on main thread

        // Added 2 seconds delay just for demo purposes to show my nice Earth-Moon spinner :)
        DispatchQueue.main.asyncAfter(deadline: .now() + withDemoDelay) {

            Task {
                do {
                    try await self.dataService.getLatestPlanets()
                    DispatchQueue.main.async { self.isLoading = false }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        if let error = error as? NetworkError {
                            debugPrint("Error occured: \(error.errorDescription)")
                            self.showError(msg: error.errorDescription)
                        } else {
                            debugPrint("Error occured: \(error)")
                            self.showError(msg: error.localizedDescription)
                        }
                    }
                    
                }
            }

        }
    }
    
    func showError(msg: String) {
        errorMessage = msg
        showAlert = true
    }
    
}
