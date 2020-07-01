//
//  BaseService.swift
//  CanadaInfo
//
//  Created by Vivek John on 01/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation

class BaseService {
    
    // Base service request for all controllers
    
    func request<T: Decodable>(for url: URL, completionHandler: @escaping ((Result<T, Error>) -> Void)) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let responseError = error {
                completionHandler(.failure(responseError))
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                // finding error
                //print("Error: invalid HTTP response code")
                let unknownError = NSError(domain: "Default Error Domain",
                                           code: -101,
                                           userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
                completionHandler(.failure(error ?? unknownError))
                return
            }
            guard let data = data else {
                let missingData = NSError(domain: "Default Error Domain",
                                          code: -101,
                                          userInfo: [NSLocalizedDescriptionKey: "Missing data"])
                completionHandler(.failure(missingData))
                return
            }
            do {
                let jsonString = String(data: data, encoding: .ascii)
                let unescapedNewlineString = jsonString?.replacingOccurrences(of: "\n", with: "")
                let unescapedTabString = unescapedNewlineString?.replacingOccurrences(of: "\t", with: "")
                guard let unescapedRawData = unescapedTabString?.data(using: .utf8) else {
                    let missingData = NSError(domain: "Default Error Domain",
                                              code: -101,
                                              userInfo: [NSLocalizedDescriptionKey: "Missing data"])
                    completionHandler(.failure(missingData))
                    return
                }
                let decoder = JSONDecoder()
                let concreteResponse = try decoder.decode(T.self, from: unescapedRawData)
                completionHandler(.success(concreteResponse))
            } catch {
                // finding error
                //print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
