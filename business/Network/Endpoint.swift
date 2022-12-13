//
//  Endpoint.swift
//  business
//
//  Created by Rahmat Hidayat on 09/12/22.
//

import Foundation
import Alamofire

enum Endpoint {
    case businessDetail(id: String)
    case reviews(id: String, params: [String: Any])
    case search(params: [String: Any])
    
    var method: HTTPMethod {
        switch self {
        case .businessDetail, .reviews, .search:
            return .get
        }
    }
    
    var url: String {
        var path = ""
        switch self {
        case .businessDetail(let id):
            path = id
        case .reviews(let id, let params):
            path = "\(id)/\(self.urlQuery("reviews", params: params))"
        case .search(let params):
            path = self.urlQuery("search", params: params)
        }
        
        return Constant.BASE_URL + path
    }
    
    private func urlQuery(_ path: String, params: [String: Any]) -> String {
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        var urlComps = URLComponents(string: path)!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
        return "\(result)"
    }
}
