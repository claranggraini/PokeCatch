import Foundation

public protocol NetworkClientProtocol: Sendable {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) async -> Result<T, NetworkError>
}
