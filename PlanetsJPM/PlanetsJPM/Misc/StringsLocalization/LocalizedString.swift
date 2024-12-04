//
//  LocalizedString.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import Foundation

struct LocalizedString {
    
    static let appName = "Planets JPM"
    
    static let errorNetworkAlertTitle = NSLocalizedString("errorNetworkAlertTitle", comment: "The alert title that we should show when a network error occured")
    static let urlIsInvalid = NSLocalizedString("urlIsInvalid", comment: "The alert message that we should show when url is invalid")
    static let networkRequestfailedGeneral = NSLocalizedString("networkRequestfailedGeneral", comment: "The alert message that we should show when network request failed but not sure why")
    static let notConnectedMessage = NSLocalizedString("notConnectedMessage", comment: "The alert message that we should show when device is not connected to internet")
    static let serverResponseNotValid = NSLocalizedString("serverResponseNotValid", comment: "The alert message that we should show when server response data seems not valid or compatible with our code")
    static let decodingErrorMessage = NSLocalizedString("decodingErrorMessage", comment: "The alert message that we should show when the app can't decode the data received from server")
    static let serverStatusCodeError = NSLocalizedString("serverStatusCodeError", comment: "The alert message that we should show when the status code was not valid")
    static let loadingText = NSLocalizedString("loadingText", comment: "Please wait text")
    
    // Planet details
    static let rotation_period = NSLocalizedString("rotation_period", comment: "Planet rotation period")
    static let orbital_period = NSLocalizedString("orbital_period", comment: "Planet orbital period")
    static let diameter = NSLocalizedString("diameter", comment: "Planet diameter")
    static let climate = NSLocalizedString("climate", comment: "Planet climate")
    static let gravity = NSLocalizedString("gravity", comment: "Planet gravity")
    static let terrain = NSLocalizedString("terrain", comment: "Planet terrain")
    static let surface_water = NSLocalizedString("surface_water", comment: "Planet surface_water")
    static let population = NSLocalizedString("population", comment: "Planet population")
    static let numberOfResidents = NSLocalizedString("numberOfResidents", comment: "Planet number of residents")
    static let numberOfFilms = NSLocalizedString("numberOfFilms", comment: "Planet number of films")
    static let createdDate = NSLocalizedString("createdDate", comment: "Planet date created")
    static let editedDate = NSLocalizedString("editedDate", comment: "Planet date edited")

    // Resident details:
    static let name = NSLocalizedString("name", comment: "Resident name")
    static let height = NSLocalizedString("height", comment: "Resident height")
    static let mass = NSLocalizedString("mass", comment: "Resident mass")
    static let hairColor = NSLocalizedString("hairColor", comment: "Resident hairColor")
    static let skinColor = NSLocalizedString("skinColor", comment: "Resident skinColor")
    static let eyeColor = NSLocalizedString("eyeColor", comment: "Resident eyeColor")
    static let birthYear = NSLocalizedString("birthYear", comment: "Resident birthYear")
    static let gender = NSLocalizedString("gender", comment: "Resident gender")
    static let homeworld = NSLocalizedString("homeworld", comment: "Resident homeworld")

}
