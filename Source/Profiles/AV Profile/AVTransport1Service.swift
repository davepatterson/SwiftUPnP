import Foundation
import Combine
import XMLCoder
import os.log

public class AVTransport1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public enum TransportStateEnum: String, Codable {
		case stopped = "STOPPED"
		case pausedPlayback = "PAUSED_PLAYBACK"
		case pausedRecording = "PAUSED_RECORDING"
		case playing = "PLAYING"
		case recording = "RECORDING"
		case transitioning = "TRANSITIONING"
		case noMediaPresent = "NO_MEDIA_PRESENT"
	}

	public enum TransportStatusEnum: String, Codable {
		case ok = "OK"
		case errorOccurred = "ERROR_OCCURRED"
		case vendorDefined = "vendor-defined"
	}

	public enum PlaybackStorageMediumEnum: String, Codable {
		case unknown = "UNKNOWN"
		case dv = "DV"
		case miniDv = "MINI-DV"
		case vhs = "VHS"
		case wVhs = "W-VHS"
		case sVhs = "S-VHS"
		case dVhs = "D-VHS"
		case vhsc = "VHSC"
		case videoeight = "VIDEO8"
		case hieight = "HI8"
		case cdRom = "CD-ROM"
		case cdDa = "CD-DA"
		case cdR = "CD-R"
		case cdRw = "CD-RW"
		case videoCd = "VIDEO-CD"
		case sacd = "SACD"
		case mdAudio = "MD-AUDIO"
		case mdPicture = "MD-PICTURE"
		case dvdRom = "DVD-ROM"
		case dvdVideo = "DVD-VIDEO"
		case dvdR = "DVD-R"
		case dvdPlusRw = "DVD+RW"
		case dvdRw = "DVD-RW"
		case dvdRam = "DVD-RAM"
		case dvdAudio = "DVD-AUDIO"
		case dat = "DAT"
		case ld = "LD"
		case hdd = "HDD"
		case microMv = "MICRO-MV"
		case network = "NETWORK"
		case none = "NONE"
		case notImplemented = "NOT_IMPLEMENTED"
		case vendorDefined = "vendor-defined"
	}

	public enum RecordStorageMediumEnum: String, Codable {
		case unknown = "UNKNOWN"
		case dv = "DV"
		case miniDv = "MINI-DV"
		case vhs = "VHS"
		case wVhs = "W-VHS"
		case sVhs = "S-VHS"
		case dVhs = "D-VHS"
		case vhsc = "VHSC"
		case videoeight = "VIDEO8"
		case hieight = "HI8"
		case cdRom = "CD-ROM"
		case cdDa = "CD-DA"
		case cdR = "CD-R"
		case cdRw = "CD-RW"
		case videoCd = "VIDEO-CD"
		case sacd = "SACD"
		case mdAudio = "MD-AUDIO"
		case mdPicture = "MD-PICTURE"
		case dvdRom = "DVD-ROM"
		case dvdVideo = "DVD-VIDEO"
		case dvdR = "DVD-R"
		case dvdPlusRw = "DVD+RW"
		case dvdRw = "DVD-RW"
		case dvdRam = "DVD-RAM"
		case dvdAudio = "DVD-AUDIO"
		case dat = "DAT"
		case ld = "LD"
		case hdd = "HDD"
		case microMv = "MICRO-MV"
		case network = "NETWORK"
		case none = "NONE"
		case notImplemented = "NOT_IMPLEMENTED"
		case vendorDefined = "vendor-defined"
	}

	public enum CurrentPlayModeEnum: String, Codable {
		case normal = "NORMAL"
		case shuffle = "SHUFFLE"
		case repeatOne = "REPEAT_ONE"
		case repeatAll = "REPEAT_ALL"
		case random = "RANDOM"
		case directOne = "DIRECT_1"
		case intro = "INTRO"
	}

	public enum TransportPlaySpeedEnum: String, Codable {
		case one = "1"
		case vendorDefined = "vendor-defined"
	}

	public enum RecordMediumWriteStatusEnum: String, Codable {
		case writable = "WRITABLE"
		case protected = "PROTECTED"
		case notWritable = "NOT_WRITABLE"
		case unknown = "UNKNOWN"
		case notImplemented = "NOT_IMPLEMENTED"
	}

	public enum CurrentRecordQualityModeEnum: String, Codable {
		case zeroEp = "0:EP"
		case oneLp = "1:LP"
		case twoSp = "2:SP"
		case zeroBasic = "0:BASIC"
		case oneMedium = "1:MEDIUM"
		case twoHigh = "2:HIGH"
		case notImplemented = "NOT_IMPLEMENTED"
		case vendorDefined = "vendor-defined"
	}

	public enum A_ARG_TYPE_SeekModeEnum: String, Codable {
		case absTime = "ABS_TIME"
		case relTime = "REL_TIME"
		case absCount = "ABS_COUNT"
		case relCount = "REL_COUNT"
		case trackNr = "TRACK_NR"
		case channelFreq = "CHANNEL_FREQ"
		case tapeIndex = "TAPE-INDEX"
		case frame = "FRAME"
	}

	public func setAVTransportURI(instanceID: UInt32, currentURI: String, currentURIMetaData: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case currentURI = "CurrentURI"
				case currentURIMetaData = "CurrentURIMetaData"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var currentURI: String
			public var currentURIMetaData: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetAVTransportURI"
			}

			var action: SoapAction
		}
		try await post(action: "SetAVTransportURI", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, currentURI: currentURI, currentURIMetaData: currentURIMetaData))), log: log)
	}

	public func setNextAVTransportURI(instanceID: UInt32, nextURI: String, nextURIMetaData: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case nextURI = "NextURI"
				case nextURIMetaData = "NextURIMetaData"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var nextURI: String
			public var nextURIMetaData: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetNextAVTransportURI"
			}

			var action: SoapAction
		}
		try await post(action: "SetNextAVTransportURI", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, nextURI: nextURI, nextURIMetaData: nextURIMetaData))), log: log)
	}

	public struct GetMediaInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case nrTracks = "NrTracks"
			case mediaDuration = "MediaDuration"
			case currentURI = "CurrentURI"
			case currentURIMetaData = "CurrentURIMetaData"
			case nextURI = "NextURI"
			case nextURIMetaData = "NextURIMetaData"
			case playMedium = "PlayMedium"
			case recordMedium = "RecordMedium"
			case writeStatus = "WriteStatus"
		}

		public var nrTracks: UInt32
		public var mediaDuration: String
		public var currentURI: String
		public var currentURIMetaData: String
		public var nextURI: String
		public var nextURIMetaData: String
		public var playMedium: PlaybackStorageMediumEnum
		public var recordMedium: RecordStorageMediumEnum
		public var writeStatus: RecordMediumWriteStatusEnum

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetMediaInfoResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))nrTracks: \(nrTracks)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))mediaDuration: '\(mediaDuration)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentURI: '\(currentURI)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentURIMetaData: '\(currentURIMetaData)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))nextURI: '\(nextURI)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))nextURIMetaData: '\(nextURIMetaData)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))playMedium: \(playMedium.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))recordMedium: \(recordMedium.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))writeStatus: \(writeStatus.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getMediaInfo(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetMediaInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetMediaInfo"
				case response = "u:GetMediaInfoResponse"
			}

			var action: SoapAction?
			var response: GetMediaInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetMediaInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetTransportInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentTransportState = "CurrentTransportState"
			case currentTransportStatus = "CurrentTransportStatus"
			case currentSpeed = "CurrentSpeed"
		}

		public var currentTransportState: TransportStateEnum
		public var currentTransportStatus: TransportStatusEnum
		public var currentSpeed: TransportPlaySpeedEnum

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetTransportInfoResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentTransportState: \(currentTransportState.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentTransportStatus: \(currentTransportStatus.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentSpeed: \(currentSpeed.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getTransportInfo(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetTransportInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetTransportInfo"
				case response = "u:GetTransportInfoResponse"
			}

			var action: SoapAction?
			var response: GetTransportInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetTransportInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetPositionInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case track = "Track"
			case trackDuration = "TrackDuration"
			case trackMetaData = "TrackMetaData"
			case trackURI = "TrackURI"
			case relTime = "RelTime"
			case absTime = "AbsTime"
			case relCount = "RelCount"
			case absCount = "AbsCount"
		}

		public var track: UInt32
		public var trackDuration: String
		public var trackMetaData: String
		public var trackURI: String
		public var relTime: String
		public var absTime: String
		public var relCount: Int32
		public var absCount: Int32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetPositionInfoResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))track: \(track)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))trackDuration: '\(trackDuration)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))trackMetaData: '\(trackMetaData)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))trackURI: '\(trackURI)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))relTime: '\(relTime)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))absTime: '\(absTime)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))relCount: \(relCount)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))absCount: \(absCount)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getPositionInfo(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetPositionInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetPositionInfo"
				case response = "u:GetPositionInfoResponse"
			}

			var action: SoapAction?
			var response: GetPositionInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetPositionInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetDeviceCapabilitiesResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case playMedia = "PlayMedia"
			case recMedia = "RecMedia"
			case recQualityModes = "RecQualityModes"
		}

		public var playMedia: String
		public var recMedia: String
		public var recQualityModes: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetDeviceCapabilitiesResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))playMedia: '\(playMedia)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))recMedia: '\(recMedia)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))recQualityModes: '\(recQualityModes)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getDeviceCapabilities(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetDeviceCapabilitiesResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetDeviceCapabilities"
				case response = "u:GetDeviceCapabilitiesResponse"
			}

			var action: SoapAction?
			var response: GetDeviceCapabilitiesResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetDeviceCapabilities", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetTransportSettingsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case playMode = "PlayMode"
			case recQualityMode = "RecQualityMode"
		}

		public var playMode: CurrentPlayModeEnum
		public var recQualityMode: CurrentRecordQualityModeEnum

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetTransportSettingsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))playMode: \(playMode.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))recQualityMode: \(recQualityMode.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getTransportSettings(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetTransportSettingsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetTransportSettings"
				case response = "u:GetTransportSettingsResponse"
			}

			var action: SoapAction?
			var response: GetTransportSettingsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetTransportSettings", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func stop(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Stop"
			}

			var action: SoapAction
		}
		try await post(action: "Stop", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)
	}

	public func play(instanceID: UInt32, speed: TransportPlaySpeedEnum, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case speed = "Speed"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var speed: TransportPlaySpeedEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Play"
			}

			var action: SoapAction
		}
		try await post(action: "Play", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, speed: speed))), log: log)
	}

	public func pause(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Pause"
			}

			var action: SoapAction
		}
		try await post(action: "Pause", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)
	}

	public func record(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Record"
			}

			var action: SoapAction
		}
		try await post(action: "Record", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)
	}

	public func seek(instanceID: UInt32, unit: A_ARG_TYPE_SeekModeEnum, target: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case unit = "Unit"
				case target = "Target"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var unit: A_ARG_TYPE_SeekModeEnum
			public var target: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Seek"
			}

			var action: SoapAction
		}
		try await post(action: "Seek", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, unit: unit, target: target))), log: log)
	}

	public func next(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Next"
			}

			var action: SoapAction
		}
		try await post(action: "Next", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)
	}

	public func previous(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Previous"
			}

			var action: SoapAction
		}
		try await post(action: "Previous", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)
	}

	public func setPlayMode(instanceID: UInt32, newPlayMode: CurrentPlayModeEnum, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case newPlayMode = "NewPlayMode"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var newPlayMode: CurrentPlayModeEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetPlayMode"
			}

			var action: SoapAction
		}
		try await post(action: "SetPlayMode", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, newPlayMode: newPlayMode))), log: log)
	}

	public func setRecordQualityMode(instanceID: UInt32, newRecordQualityMode: CurrentRecordQualityModeEnum, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case newRecordQualityMode = "NewRecordQualityMode"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var newRecordQualityMode: CurrentRecordQualityModeEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetRecordQualityMode"
			}

			var action: SoapAction
		}
		try await post(action: "SetRecordQualityMode", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, newRecordQualityMode: newRecordQualityMode))), log: log)
	}

	public struct GetCurrentTransportActionsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case actions = "Actions"
		}

		public var actions: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetCurrentTransportActionsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))actions: '\(actions)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getCurrentTransportActions(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetCurrentTransportActionsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetCurrentTransportActions"
				case response = "u:GetCurrentTransportActionsResponse"
			}

			var action: SoapAction?
			var response: GetCurrentTransportActionsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetCurrentTransportActions", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension AVTransport1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case lastChange = "LastChange"
		}

		public var lastChange: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))AVTransport1ServiceState {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))lastChange: '\(lastChange ?? "nil")'")
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
			if let lastChange = property.lastChange {
				result.lastChange = lastChange
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
