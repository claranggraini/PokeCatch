//
//  Endpoint.swift
//  Networking
//
//  Created by Clara on 01/10/26.
//

import Foundation

public protocol Endpoint {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var query: [URLQueryItem]? { get }
}

public extension Endpoint {
    var method: HTTPMethod { .get }
    var header: [String: String]? { nil }
    var body: [String: Any]? { nil }
    var query: [URLQueryItem]? { nil }
    
    var urlRequest: URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = query
        
        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header

        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return urlRequest
    }
}
