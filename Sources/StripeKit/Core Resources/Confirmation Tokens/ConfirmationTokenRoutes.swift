//
//  ConfirmationTokenRoutes.swift
//  StripeKit
//

import NIO
import NIOHTTP1

public protocol ConfirmationTokenRoutes: StripeAPIRoute {
    /// Retrieves a ConfirmationToken object.
    /// - Parameters:
    /// - token: The ID of the ConfirmationToken to retrieve
    /// - Returns: Returns a ConfirmationToken if a valid ID was provided. Returns an error otherwise.
    func retrieve(token: String) async throws -> ConfirmationToken
}

public struct StripeConfirmationTokenRoutes: ConfirmationTokenRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let confirmationTokens = APIBase + APIVersion + "confirmation_tokens"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(token: String) async throws -> ConfirmationToken {
        try await apiHandler.send(method: .GET,
                                path: "\(confirmationTokens)/\(token)",
                                headers: headers)
    }
} 