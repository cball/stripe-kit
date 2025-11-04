//
//  PaymentMethodDomainRoutes.swift
//  StripeKit
//

import NIO
import NIOHTTP1

public protocol PaymentMethodDomainRoutes: StripeAPIRoute {
    /// Retrieves a PaymentMethodDomain object.
    /// - Parameter id: The ID of the PaymentMethodDomain to retrieve
    /// - Returns: Returns a PaymentMethodDomain if a valid ID was provided. Returns an error otherwise.
    func retrieve(id: String) async throws -> PaymentMethodDomain
    
    /// Creates a PaymentMethodDomain object.
    /// - Parameters:
    ///   - domainName: The domain name that this payment method domain object represents
    ///   - enabled: Whether this payment method domain should accept payments. Defaults to true if not provided.
    /// - Returns: Returns the PaymentMethodDomain object.
    func create(domainName: String, enabled: Bool?) async throws -> PaymentMethodDomain

    /// Updates a PaymentMethodDomain object.
    /// - Parameters:
    ///   - id: The ID of the PaymentMethodDomain to update
    ///   - enabled: Whether this payment method domain should accept payments
    /// - Returns: Returns the updated PaymentMethodDomain object.
    func update(id: String, enabled: Bool) async throws -> PaymentMethodDomain

    /// Returns a list of your payment method domains.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of payment method domains.
    func listAll(filter: [String: Any]?) async throws -> PaymentMethodDomainList
    
    /// Validates a payment method domain.
    /// See [Stripe's docs](https://docs.stripe.com/payments/payment-methods/pmd-registration) for more information.
    /// - Parameter id: The ID of the PaymentMethodDomain to validate
    /// - Returns: Returns the PaymentMethodDomain object if the validation succeeded.
    func validate(id: String) async throws -> PaymentMethodDomain
}

public struct StripePaymentMethodDomainRoutes: PaymentMethodDomainRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let paymentMethodDomains = APIBase + APIVersion + "payment_method_domains"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String) async throws -> PaymentMethodDomain {
        try await apiHandler.send(method: .GET,
                                path: "\(paymentMethodDomains)/\(id)",
                                headers: headers)
    }
    
    public func create(domainName: String, enabled: Bool? = nil) async throws -> PaymentMethodDomain {
        var body: [String: Any] = ["domain_name": domainName]
        
        if let enabled {
            body["enabled"] = enabled
        }
        
        return try await apiHandler.send(method: .POST,
                                       path: paymentMethodDomains,
                                       body: .string(body.queryParameters),
                                       headers: headers)
    }
    
    public func update(id: String, enabled: Bool) async throws -> PaymentMethodDomain {
        let body: [String: Any] = ["enabled": enabled]
        
        return try await apiHandler.send(method: .POST,
                                       path: "\(paymentMethodDomains)/\(id)",
                                       body: .string(body.queryParameters),
                                       headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> PaymentMethodDomainList {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET,
                                       path: paymentMethodDomains,
                                       query: queryParams,
                                       headers: headers)
    }
    
    public func validate(id: String) async throws -> PaymentMethodDomain {
        try await apiHandler.send(method: .POST,
                                path: "\(paymentMethodDomains)/\(id)/validate",
                                headers: headers)
    }
}

public struct PaymentMethodDomainList: Codable {
    public var object: String
    public var data: [PaymentMethodDomain]
    public var hasMore: Bool
    public var url: String
    
    private enum CodingKeys: String, CodingKey {
        case object, data
        case hasMore = "has_more"
        case url
    }
} 
