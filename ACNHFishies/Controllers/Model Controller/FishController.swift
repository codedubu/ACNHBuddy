//
//  FishController.swift
//  ACNHFishies
//
//  Created by River McCaine on 1/27/21.
//

import UIKit

// Trying to get here -> http://acnhapi.com/v1/fish/{fishID}

class FishController {
    
    static let baseURL = URL(string:"https://acnhapi.com/v1a/fish/")
    
    static func fetchFish(id: String, completion: @escaping (Result<Fish,FishError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let finalURL = baseURL.appendingPathComponent(id)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            do {
                let decodedFish = try JSONDecoder().decode(Fish.self, from: data)
                
                return completion(.success(decodedFish))
            } catch {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    } // END OF FUNC
    
    static func fetchFishSprite(for fish: Fish, completion: @escaping (Result<UIImage, FishError>) -> Void) {
        
        let fishURL = fish.imageURL
        
        URLSession.shared.dataTask(with: fishURL) { (data, _, error) in
            if let error = error {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            guard let fishSprite = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(fishSprite))
        }.resume()
    } // END OF FUNC
    
    static func fetchAllFish(completion: @escaping (Result<[Fish], FishError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let finalURL = baseURL
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            do {
                let decodedFish = try JSONDecoder().decode([Fish].self, from: data)
                
                return completion(.success(decodedFish))
            } catch {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    } // END OF FUNC
    
    
} // END OF CLASS
