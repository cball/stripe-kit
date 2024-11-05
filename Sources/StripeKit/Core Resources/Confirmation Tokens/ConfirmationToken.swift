//
//  ConfirmationToken.swift
//  StripeKit
//
import Foundation

/// The [ConfirmationToken Object](https://stripe.com/docs/api/confirmation_tokens/object) .
public struct ConfirmationToken: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object's type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Time at which this ConfirmationToken expires
    public var expiresAt: Date?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Data used for generating a Mandate.
    public var mandateData: ConfirmationTokenMandateData?
    /// ID of the PaymentIntent that this ConfirmationToken was used to confirm
    public var paymentIntent: String?
    /// Payment-method-specific configuration
    public var paymentMethodOptions: ConfirmationTokenPaymentMethodOptions?
    /// Payment details collected by the Payment Element
    public var paymentMethodPreview: PaymentMethodPreview?
    /// Return URL used to confirm the Intent
    public var returnUrl: String?
    /// Indicates that you intend to make future payments with this ConfirmationToken's payment method
    public var setupFutureUsage: ConfirmationTokenSetupFutureUsage?
    /// ID of the SetupIntent that this ConfirmationToken was used to confirm. null if the ConfirmationToken has not been used
    public var setupIntent: String?
    /// Shipping information collected on this ConfirmationToken
    public var shipping: ConfirmationTokenShipping?
    /// Indicates whether the Stripe SDK is used to handle confirmation flow. Defaults to true on ConfirmationToken
    public var useStripeSdk: Bool
    
    public init(id: String,
                object: String,
                created: Date,
                expiresAt: Date? = nil,
                livemode: Bool? = nil,
                mandateData: ConfirmationTokenMandateData? = nil,
                paymentIntent: String? = nil,
                paymentMethodOptions: ConfirmationTokenPaymentMethodOptions? = nil,
                paymentMethodPreview: PaymentMethod? = nil,
                returnUrl: String? = nil,
                setupFutureUsage: ConfirmationTokenSetupFutureUsage? = nil,
                setupIntent: String? = nil,
                shipping: ConfirmationTokenShipping? = nil,
                useStripeSdk: Bool) {
        self.id = id
        self.object = object
        self.created = created
        self.expiresAt = expiresAt
        self.livemode = livemode
        self.mandateData = mandateData
        self.paymentIntent = paymentIntent
        self.paymentMethodOptions = paymentMethodOptions
        self.paymentMethodPreview = paymentMethodPreview
        self.returnUrl = returnUrl
        self.setupFutureUsage = setupFutureUsage
        self.setupIntent = setupIntent
        self.shipping = shipping
        self.useStripeSdk = useStripeSdk
    }
}

public struct ConfirmationTokenMandateData: Codable {
    /// This hash contains details about the customer acceptance of the Mandate
    public var customerAcceptance: ConfirmationTokenMandateCustomerAcceptance?
}

public struct ConfirmationTokenMandateCustomerAcceptance: Codable {
    public var online: MandateCustomerAcceptanceOnline?
    public var type: MandateCustomerAcceptanceType?
}

public struct ConfirmationTokenPaymentMethodOptions: Codable {
    /// This hash contains the card payment method options
    public var card: ConfirmationTokenCardOptions?
}

public struct ConfirmationTokenCardOptions: Codable {
    /// The cvc_update Token collected from the Payment Element
    public var cvcToken: String?
}

public enum ConfirmationTokenSetupFutureUsage: String, Codable {
    /// Use off_session if your customer may or may not be present in your checkout flow
    case offSession = "off_session"
    /// Use on_session if you intend to only reuse the payment method when your customer is present in your checkout flow
    case onSession = "on_session"
}

public struct ConfirmationTokenShipping: Codable {
    /// Shipping address
    public var address: Address?
    /// Recipient name
    public var name: String
    /// Recipient phone (including extension)
    public var phone: String?
}

