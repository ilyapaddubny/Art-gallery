//
//  DataManager.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 15.02.2024.
//

import Foundation

class DataManager {
    func fetchDataOnline(completion: @escaping ((Result<[Artist], Error>) -> Void)) {
        guard let url = URL(string: Constants.artistURLString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let urlSession = URLSession.shared
        
        // Creating a data task to fetch the data from the URL
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🔴 \(error.localizedDescription)")
                completion(.failure(NetworkError.noData))
                return
            }
            
           guard let httpResponse = response as? HTTPURLResponse,
                 (200...209).contains(httpResponse.statusCode) else {
               completion(.failure(NetworkError.noData))
               return
           }
            
            guard let jsonData = data else {
                print("🔴 No data received")
                completion(.failure(NetworkError.noData))
                return
            }
            
            guard let artistsData = try? JSONDecoder().decode(ArtistsData.self, from: jsonData) else {
                print("🔴 Failed to decode artists data")
                completion(.failure(NetworkError.decodingError))
                return
            }
            
            completion(.success(artistsData.artists))
            
//            UserDefaults(suiteName: "group.paddubny.Art-gallery")?.setValue(artists, forKey: ArtistsVC.Constants.Strings.key)
        }
        
        task.resume()
    }
}

extension DataManager {
    private struct Constants {
        static let artistURLString = "https://file.notion.so/f/f/b8bbfa88-ab7c-464e-8c0e-1c109af93066/8c0c0258-c23a-4229-ae76-b515867cc1d8/artists.json?id=65f3a8fb-a15e-48f4-a7ed-f75be1b2f4fb&table=block&spaceId=b8bbfa88-ab7c-464e-8c0e-1c109af93066&expirationTimestamp=1708005600000&signature=BqHK8Pd5dUdAbQyCCHky4wrWjAxXXgzjq9moJlYFvFc&downloadName=artists.json"
    }
    
    enum NetworkError: Error {
        case invalidURL, noData, decodingError
    }
}
