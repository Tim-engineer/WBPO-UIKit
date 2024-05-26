//
//  AlertItem.swift
//  WBPO-UIKit
//
//  Created by Tim Matlak on 26/05/2024.
//

import UIKit

struct AlertItem {
    let title: String
    let message: String
    let dismissButtonTitle: String
}


struct AlertContext {
    static let invalidURL = AlertItem(title: "Server Error", message: "There was an issue connecting to the server. If this persists, please contact support.", dismissButtonTitle: "OK")

    static let invalidResponse = AlertItem(title: "Server Error", message: "Invalid response from the server. Please try again later or contact support.", dismissButtonTitle: "OK")

    static let invalidData = AlertItem(title: "Server Error", message: "The data received from the server was invalid. Please contact support.", dismissButtonTitle: "OK")

    static let unableToComplete = AlertItem(title: "Server Error", message: "There was an issue connecting to the server. If this persists, please contact support.", dismissButtonTitle: "OK")
}

