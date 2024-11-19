//
//  PaymentMethodDomain.swift
//  StripeKit
//
import Foundation

/// The PaymentMethodDomain object.
/// A payment method domain represents a web domain that you have registered with Stripe. Stripe Elements use registered payment method domains to control where certain payment methods are shown.
public struct PaymentMethodDomain: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object's type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The domain name that this payment method domain object represents.
    public var domainName: String
    /// Whether this payment method domain is enabled to accept payments.
    public var enabled: Bool
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// The status of Amazon Pay’s eligibility on the domain.
    public var amazonPay: PaymentMethodDomainDetails
    /// The status of Apple Pay's eligibility on the domain.
    public var applePay: PaymentMethodDomainDetails
    /// The status of Google Pay's eligibility on the domain.
    public var googlePay: PaymentMethodDomainDetails
    /// The status of Link's eligibility on the domain.
    public var link: PaymentMethodDomainDetails
    /// The status of PayPal's eligibility on the domain.
    public var paypal: PaymentMethodDomainDetails
    
    public init(id: String,
                object: String,
                created: Date,
                domainName: String,
                enabled: Bool,
                livemode: Bool,
                amazonPay: PaymentMethodDomainDetails,
                applePay: PaymentMethodDomainDetails,
                googlePay: PaymentMethodDomainDetails,
                link: PaymentMethodDomainDetails,
                paypal: PaymentMethodDomainDetails) {
        self.id = id
        self.object = object
        self.created = created
        self.domainName = domainName
        self.enabled = enabled
        self.livemode = livemode
        self.amazonPay = amazonPay
        self.applePay = applePay
        self.googlePay = googlePay
        self.link = link
        self.paypal = paypal
    }
}

/// The status of a payment method's eligibility on a domain.
public struct PaymentMethodDomainDetails: Codable {
    public var status: PaymentMethodDomainStatus
    public var statusDetails: PaymentMethodDomainStatusDetails?
}

/// Additional details about the satus of the payment method on the domain.
public struct PaymentMethodDomainStatusDetails: Codable {
  public var errorMessage: String
}

/// The status of the payment method on the domain
public enum PaymentMethodDomainStatus: String, Codable {
    case active
    case inactive
} 
