//
//  PlanetsJPMApp.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import SwiftUI

@main
struct PlanetsJPMApp: App {

    @StateObject var themeService = ThemeService.shared
    @Environment(\.colorScheme) var colorScheme

    var body: some Scene {
        WindowGroup {
            PlanetsView()
                .environmentObject(themeService)
        }
    }
    
        
}

/*
Minimum Requirements
• The application should have a screen which displays a list of planet names from the first page of planet data -> DONE
• Planets should be persisted for offline viewing -> DONE (Look at DataService -> saveToCache and loadPlanetsFromCache)
• Minimum iOS version should be 15.0 -> DONE
• The app should be universal -> DONE works great on iPad and MAC
• The app should be appropriately unit tested -> Done
• Use SwiftUI, Combine, Codable where appropriate. -> Done
• Code should be appropriately documented -> Done
• You do not have to load more than the first page of data -> Done
• Only use the standard Apple iOS frameworks, do not use any third-party libraries -> Done
 
If you are invited for a follow-up system design interview, part of that will involve expanding
upon your solution to the challenge. Keep that in mind as you design your app.

Suggestions:
 // 1.. Each planet and each resident should have an id but now it doesn't. So I picked the "name" of the planet as id of the planet and the "url" of resident as id of ResidentDTO
 // 2.. Remove from server response the variable name: "previous", its always null and not used
 // 3.. We could get urls for images per planet in order to show on the list to look more beautiful
 // 4.. Instead of having separate resident urls inside the planet object we should get one url which would return the data of all the residents
 // 5.. We could have moving planets as background in the main planets list to have more alive and modern look
 // 6.. We could show the startships data inside the planet details screen and if we had an image of each startship would also be great
 // 7.. We could show the vehicles data inside the planet details screen and if we had an image of each vehicles would also be great
 // 8.. We could list all the species inside the planet details screen
 
 Extra features I added:
 1.. Dark theme support
 2.. Custom spinner based on earth and moon icons
 3.. Navigation to the planet details screen
 4.. Navigation to Residence list details of each planet
 5.. Drag to refresh planets feature in main screen
 */
