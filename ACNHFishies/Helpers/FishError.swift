//
//  FishError.swift
//  ACNHFishies
//
//  Created by River McCaine on 1/27/21.
//

import Foundation

enum FishError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The server failed to reach the needed URL."
        case .thrownError(let error):
            return "Uh oh, there wasn error: \(error.localizedDescription)"
        case .noData:
            return "The server failed to load any data."
        case .unableToDecode:
            return "There was an error when trying to load the data."
        }
    }
} // END OF ENUM
