//
//  NetworkClient.swift
//  Networking
//
//  Created by Clara on 01/10/26.
//
import Foundation

final class NetworkService: NetworkClientProtocol {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) async -> Result<T, URLError> {
        
        guard let urlRequest = endpoint.urlRequest else {
            return .failure(.invalidResponse)
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            guard response.statusCode != 404 else {
                
                return .failure(.invalidResponse)
            }
            
            guard let decodedData = try? JSONDecoder().decode(model, from: data) else {

                return .failure(.decoding)
            }
            
            return .success(decodedData)
            
        } catch {
            return .failure(.underlying(error))
        }
    }
}
