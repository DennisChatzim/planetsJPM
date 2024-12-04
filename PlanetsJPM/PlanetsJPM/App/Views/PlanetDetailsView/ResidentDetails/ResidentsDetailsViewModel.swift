//
//  ResidentsDetailsViewModel.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 19/11/24.
//

import SwiftUI

class ResidentsDetailsViewModel: ObservableObject {
    
    var residentsUrls: [String] = []
    var residents: [ResidentDTO] = []
    let dataService: DataServiceProtocol
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String = ""

    init(dataService: DataServiceProtocol) {
        
        self.dataService = dataService
        
    }
    
    init(residentsUrls: [String],
         dataService: DataServiceProtocol) {
        
        self.dataService = dataService
        self.residentsUrls = residentsUrls
        getAllResidentsData()
        
    }
    
    func getAllResidentsData() {
                
        DispatchQueue.main.async { self.isLoading = true } // We need this on main thread
        
        // Added 2 seconds delay just for demo purposes to show my nice Earth-Moon spinner :)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            var completedResidentsCalls = 0
            
            for residentUrl in self.residentsUrls {
                
                Task {
                    
                    do {
                        let resident = try await self.dataService.getResidentDetails(residentUrl: residentUrl)
                        self.residents.append(resident)
                        completedResidentsCalls += 1
                        if completedResidentsCalls == self.residentsUrls.count {
                            DispatchQueue.main.async { self.isLoading = false }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completedResidentsCalls += 1
                            if completedResidentsCalls == self.residentsUrls.count {
                                DispatchQueue.main.async { self.isLoading = false }
                            }
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
    }
    
    func showError(msg: String) {
        errorMessage = msg
        showAlert = true
    }
    
}
