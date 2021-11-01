//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse, data:Data?=nil) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default:
            do{
                if let responseData = data {
//                    let apiResponse = try JSONDecoder().decode(UserProfileApiResponse.self, from: responseData)
//                    if let error = apiResponse.errorDescription {
//                        return .failure(error)
//                    }
                }
            }catch{
                print("Error Catched")
            }
            
            
            return .failure(NetworkResponse.failed.rawValue)
        
        }
    }
}
