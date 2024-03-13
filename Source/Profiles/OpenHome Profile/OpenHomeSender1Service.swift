import Foundation
import Combine
import XMLCoder
import os.log

public class OpenHomeSender1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public enum StatusEnum: String, Codable {
		case blocked = "Blocked"
		case disabled = "Disabled"
		case enabled = "Enabled"
	}

	public struct PresentationUrlResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))PresentationUrlResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: '\(value)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func presentationUrl(log: UPnPService.MessageLog = .none) async throws -> PresentationUrlResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:PresentationUrl"
				case response = "u:PresentationUrlResponse"
			}

			var action: SoapAction?
			var response: PresentationUrlResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "PresentationUrl", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct MetadataResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))MetadataResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: '\(value)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func metadata(log: UPnPService.MessageLog = .none) async throws -> MetadataResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Metadata"
				case response = "u:MetadataResponse"
			}

			var action: SoapAction?
			var response: MetadataResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Metadata", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct AudioResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))AudioResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func audio(log: UPnPService.MessageLog = .none) async throws -> AudioResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Audio"
				case response = "u:AudioResponse"
			}

			var action: SoapAction?
			var response: AudioResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Audio", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct StatusResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: StatusEnum

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))StatusResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func status(log: UPnPService.MessageLog = .none) async throws -> StatusResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Status"
				case response = "u:StatusResponse"
			}

			var action: SoapAction?
			var response: StatusResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Status", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct AttributesResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))AttributesResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: '\(value)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func attributes(log: UPnPService.MessageLog = .none) async throws -> AttributesResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Attributes"
				case response = "u:AttributesResponse"
			}

			var action: SoapAction?
			var response: AttributesResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Attributes", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension OpenHomeSender1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case presentationUrl = "PresentationUrl"
			case metadata = "Metadata"
			case audio = "Audio"
			case status = "Status"
			case attributes = "Attributes"
		}

		public var presentationUrl: String?
		public var metadata: String?
		public var audio: Bool?
		public var status: StatusEnum?
		public var attributes: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))OpenHomeSender1ServiceState {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))presentationUrl: '\(presentationUrl ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))metadata: '\(metadata ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))audio: \((audio == nil) ? "nil" : (audio! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))status: \(status?.rawValue ?? "nil")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))attributes: '\(attributes ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}

	public func state(xml: Data) throws -> State {
		struct PropertySet: Codable {
			var property: [State]
		}

		let decoder = XMLDecoder()
		decoder.shouldProcessNamespaces = true
		let propertySet = try decoder.decode(PropertySet.self, from: xml)

		return propertySet.property.reduce(State()) { partialResult, property in
			var result = partialResult
			if let presentationUrl = property.presentationUrl {
				result.presentationUrl = presentationUrl
			}
			if let metadata = property.metadata {
				result.metadata = metadata
			}
			if let audio = property.audio {
				result.audio = audio
			}
			if let status = property.status {
				result.status = status
			}
			if let attributes = property.attributes {
				result.attributes = attributes
			}
			return result
		}
	}

	public var stateSubject: AnyPublisher<State, Never> {
		subscribedEventPublisher
			.compactMap { [weak self] in
				guard let self else { return nil }

				return try? self.state(xml: $0)
			}
			.eraseToAnyPublisher()
	}

	public var stateChangeStream: AsyncStream<State> {
		stateSubject.stream
	}
}
