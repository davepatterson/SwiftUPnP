import Foundation
import Combine
import XMLCoder
import os.log

public class OpenHomeReceiver1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public enum TransportStateEnum: String, Codable {
		case buffering = "Buffering"
		case playing = "Playing"
		case stopped = "Stopped"
		case waiting = "Waiting"
	}

	public func play(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Play"
			}

			var action: SoapAction
		}
		try await post(action: "Play", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func stop(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Stop"
			}

			var action: SoapAction
		}
		try await post(action: "Stop", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func setSender(uri: String, metadata: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case uri = "Uri"
				case metadata = "Metadata"
			}

			@Attribute var urn: String
			public var uri: String
			public var metadata: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetSender"
			}

			var action: SoapAction
		}
		try await post(action: "SetSender", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), uri: uri, metadata: metadata))), log: log)
	}

	public struct SenderResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case uri = "Uri"
			case metadata = "Metadata"
		}

		public var uri: String
		public var metadata: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))SenderResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))uri: '\(uri)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))metadata: '\(metadata)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func sender(log: UPnPService.MessageLog = .none) async throws -> SenderResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Sender"
				case response = "u:SenderResponse"
			}

			var action: SoapAction?
			var response: SenderResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Sender", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ProtocolInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ProtocolInfoResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: '\(value)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func protocolInfo(log: UPnPService.MessageLog = .none) async throws -> ProtocolInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ProtocolInfo"
				case response = "u:ProtocolInfoResponse"
			}

			var action: SoapAction?
			var response: ProtocolInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ProtocolInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct TransportStateResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: TransportStateEnum

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))TransportStateResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func transportState(log: UPnPService.MessageLog = .none) async throws -> TransportStateResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:TransportState"
				case response = "u:TransportStateResponse"
			}

			var action: SoapAction?
			var response: TransportStateResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "TransportState", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension OpenHomeReceiver1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case uri = "Uri"
			case metadata = "Metadata"
			case transportState = "TransportState"
			case protocolInfo = "ProtocolInfo"
		}

		public var uri: String?
		public var metadata: String?
		public var transportState: TransportStateEnum?
		public var protocolInfo: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))OpenHomeReceiver1ServiceState {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))uri: '\(uri ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))metadata: '\(metadata ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))transportState: \(transportState?.rawValue ?? "nil")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))protocolInfo: '\(protocolInfo ?? "nil")'")
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
			if let uri = property.uri {
				result.uri = uri
			}
			if let metadata = property.metadata {
				result.metadata = metadata
			}
			if let transportState = property.transportState {
				result.transportState = transportState
			}
			if let protocolInfo = property.protocolInfo {
				result.protocolInfo = protocolInfo
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
