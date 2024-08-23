//
//  ErrorMessages.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 28.08.2024.
//

import Foundation


enum CFError : String, Error{
    
    case invalidUsername = "This username is created invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data recieved from the server was invalid. Please try again"
    case unableToFavorite = "Unable to favorite this user. Please try again."
    case alreadyInFavorite = "This user is already in your favorite list."
}
