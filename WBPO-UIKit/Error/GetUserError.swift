//
//  GetUserError.swift
//  WBPO-UIKit
//
//  Created by Tim Matlak on 26/05/2024.
//

import Foundation

enum GetUserError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
