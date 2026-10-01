//
//  NetworkError.swift
//  Networking
//
//  Created by Clara on 01/10/26.
//

import Foundation

enum URLError: LocalizedError {
    case unauthorized
    case invalidResponse
    case decoding
    case underlying(Error)
}
