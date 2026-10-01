//
//  HTTPMethod.swift
//  Networking
//
//  Created by Clara on 01/10/26.
//

import Foundation

public enum HTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
