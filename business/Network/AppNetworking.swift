//
//  AppNetworking.swift
//  business
//
//  Created by Rahmat Hidayat on 09/12/22.
//

import Foundation
import Alamofire

struct AppNetworking{
    
    /// Base request API with generics request and response data and error message
    ///
    /// Parameters:
    ///  - T: Response decodable
    ///  - Endpoint: Endpoint API
    ///
    /// Completion:
    ///  - T: Response decodable
    ///  - ErrorType: Error message
    static func request<T: Decodable>(of type: T.Type,
                                      endpoint: Endpoint,
                                      completion: @escaping (Result<T, ErrorType>) -> Void)
    {
        if Reachability.isConnectedToNetwork() {
            let headers: HTTPHeaders = [.authorization(bearerToken: Constant.TOKEN_API)]
                
            AF.request(endpoint.url, method: endpoint.method, encoding: JSONEncoding.default, headers: headers)
                .responseData(completionHandler: { (response) in
                    switch response.result {
                    case .success(let data):
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(result))
                        }catch {
                            completion(.failure(.networkError))
                        }
                    case .failure(_):
                        completion(.failure(.networkError))
                    }
                })
        }else{
            completion(.failure(.noConnection))
        }
    }
    
}
