//
//  FormUrlEncoding.swift
//  FileManager
//
//  Created by Naveen Chauhan on 15/10/21.
//

import UIKit


public struct FormUrlEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = parameters.reduce(""){ $0.isEmpty ? "\($1.key)=\($1.value)" : "\($0)+\($1.key)=\($1.value)" }.replacingOccurrences(of: "+", with: "&").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!.data(using: .utf8)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
