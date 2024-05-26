//
//  UserViewModel.swift
//  WBPO-UIKit
//
//  Created by Tim Matlak on 26/05/2024.
//

import UIKit

final class UserViewModel {
    
    var users: [User] = []
    var alertItem: AlertItem?
    var isLoading = false
    
    func getUsers() {
        isLoading = true
        
        Task {
            do {
                users = try await NetworkManager.shared.getUsers()
                isLoading = false
            } catch {
                if let userError = error as? GetUserError {
                    switch userError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.invalidResponse
                }
                alertItem = AlertContext.invalidResponse
                isLoading = false
            }
        }
    }
}

