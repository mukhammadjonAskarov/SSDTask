//
//  Errors.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import Foundation
enum Errors: String, Error {
    
    case invalidLinkAddress  = "This Link created an invalid request. Please, try again."
    case unableToComplete = "Unable to complete Your request. Please, check your internet connection"
    case invalidResponse  = "Invalid response from the  server. Please, Try again."
    case invalidData      = "The data received from the server was invalid "
}
