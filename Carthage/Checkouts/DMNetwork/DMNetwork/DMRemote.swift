//
//  DMNetwork.swift
//  DMNetwork
//
//  Created by Dan Mori on 08/05/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import Foundation

enum DMNetworkError: Error {
    case invalidURLRequest
}

public class DMRemote {
    /**
     Makes a API connection and returns a mapped object
     
     - Parameter attempts: optional times to execute an API call value, default is 3
     - Parameter acceptedStatusCodes: optional array of accepted status codes, default is a range from 200 up to 299
     - Parameter request: the actual DMRequest to be made
     - Parameter completionHandler: Execution block after call returns
     
     */
    public static func makeRequest<T: Decodable>(attempts:Int = 3, acceptedStatusCodes: [Int] = Array(200...299), request: DMRequest, completionHandler: @escaping (T?, _ errorMessage: String?) -> Void) {
        let cp = completionHandler
        do {
            try self.networkRequest(request: request, completionHandler: { response in
                
                if !acceptedStatusCodes.contains(response.statusCode ?? -1)
                    && attempts > 0 {
                    makeRequest(attempts: (attempts-1), request: request, completionHandler: cp)
                } else {
                    guard let data = response.data  else {
                        completionHandler(nil, response.error?.localizedDescription)
                        return
                    }
                    
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(object, nil)
                    } catch let error {
                        completionHandler(nil, "Não foi possível mapear objeto: \(error.localizedDescription)")
                    }
                }
            })
        } catch {
            completionHandler(nil, "Não foi possível processar sua requisição.")
        }
        
    }
    
    /**
     Private function that makes the actual request to the API
     
     - Parameter request: DMRequest to be made
     - Parameter completionHandler: Execution block after request was made
     
     */
    fileprivate static func networkRequest(request: DMRequest, completionHandler: @escaping (_ response: DMResponse) -> Void) throws {
        guard let urlRequest: URLRequest = request.asURLRequest() else {
            throw DMNetworkError.invalidURLRequest
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            var dmresponse = DMResponse(data: data, response: response, error: error)
            
            if let httpResponse = response as? HTTPURLResponse {
                dmresponse.statusCode = httpResponse.statusCode
            }
            
            DispatchQueue.main.async() {
                completionHandler(dmresponse)
            }
        }
        
        task.resume()
    }
}
