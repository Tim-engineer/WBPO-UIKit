//
//  NetworkManager.swift
//  WBPO-UIKit
//
//  Created by Tim Matlak on 26/05/2024.
//

import UIKit

final class NetworkManager {

    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()

    static let baseURL = "https://reqres.in/api/"
    private let usersURL = baseURL + "users?page=1&per_page=15"

    private init() {}

    func getUsers() async throws -> [User] {
        guard let url = URL(string: usersURL) else {
            throw GetUserError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let userResponse = try decoder.decode(UserResponse.self, from: data)
            return userResponse.data
        } catch {
            throw GetUserError.invalidData
        }
    }

    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completed(nil)
                return
            }

            guard let data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }

        task.resume()
    }
}
