import Foundation
import Prch

public extension Events {
  /** Bulk mutate various attributes on issues.  The list of issues to modify is given through the `id` query parameter.  It is repeated for each issue that should be modified.
   - For non-status updates, the `id` query parameter is required.
   - For status updates, the `id` query parameter may be omitted
   for a batch "update all" query.
   - An optional `status` query parameter may be used to restrict
   mutations to only events with the given status.
   The following attributes can be modified and are supplied as JSON object in the body:
   If any ids are out of scope this operation will succeed without any data mutation. */
  enum BulkMutateaListOfIssues {
    public static let service = APIService<Response>(id: "Bulk Mutate a List of Issues", tag: "Events", method: "PUT", path: "/api/0/projects/{organization_slug}/{project_slug}/issues/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:write"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      /** Bulk mutate various attributes on issues.  The list of issues to modify is given through the `id` query parameter.  It is repeated for each issue that should be modified.
       - For non-status updates, the `id` query parameter is required.
       - For status updates, the `id` query parameter may be omitted
       for a batch "update all" query.
       - An optional `status` query parameter may be used to restrict
       mutations to only events with the given status.
       The following attributes can be modified and are supplied as JSON object in the body:
       If any ids are out of scope this operation will succeed without any data mutation. */
      public struct Body: Model {
        /** The actor id (or username) of the user or team that should be assigned to this issue. */
        public var assignedTo: String?

        /** In case this API call is invoked with a user context this allows changing of the flag that indicates if the user has seen the event. */
        public var hasSeen: Bool?

        /** The number of minutes to ignore this issue. */
        public var ignoreDuration: Int?

        /** In case this API call is invoked with a user context this allows changing of the bookmark flag. */
        public var isBookmarked: Bool?

        /** Sets the issue to public or private. */
        public var isPublic: Bool?

        /** Allows to merge or unmerge different issues. */
        public var merge: Bool?

        /** The new status for the issues. Valid values are `"resolved"`, `"resolvedInNextRelease"`, `"unresolved"`, and `"ignored"`. */
        public var status: String?

        /** Additional details about the resolution. Valid values are `"inRelease"`, `"inNextRelease"`, `"inCommit"`, `"ignoreDuration"`, `"ignoreCount"`, `"ignoreWindow"`, `"ignoreUserCount"`, and `"ignoreUserWindow"`. */
        public var statusDetails: StatusDetails?

        /** Additional details about the resolution. Valid values are `"inRelease"`, `"inNextRelease"`, `"inCommit"`, `"ignoreDuration"`, `"ignoreCount"`, `"ignoreWindow"`, `"ignoreUserCount"`, and `"ignoreUserWindow"`. */
        public struct StatusDetails: Model {
          public var ignoreCount: Int?

          public var ignoreDuration: Int?

          public var ignoreUserCount: Int?

          public var ignoreUserWindow: Int?

          public var ignoreWindow: Int?

          public var inCommit: String?

          public var inNextRelease: Bool?

          public var inRelease: String?

          public init(ignoreCount: Int? = nil, ignoreDuration: Int? = nil, ignoreUserCount: Int? = nil, ignoreUserWindow: Int? = nil, ignoreWindow: Int? = nil, inCommit: String? = nil, inNextRelease: Bool? = nil, inRelease: String? = nil) {
            self.ignoreCount = ignoreCount
            self.ignoreDuration = ignoreDuration
            self.ignoreUserCount = ignoreUserCount
            self.ignoreUserWindow = ignoreUserWindow
            self.ignoreWindow = ignoreWindow
            self.inCommit = inCommit
            self.inNextRelease = inNextRelease
            self.inRelease = inRelease
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            ignoreCount = try container.decodeIfPresent("ignoreCount")
            ignoreDuration = try container.decodeIfPresent("ignoreDuration")
            ignoreUserCount = try container.decodeIfPresent("ignoreUserCount")
            ignoreUserWindow = try container.decodeIfPresent("ignoreUserWindow")
            ignoreWindow = try container.decodeIfPresent("ignoreWindow")
            inCommit = try container.decodeIfPresent("inCommit")
            inNextRelease = try container.decodeIfPresent("inNextRelease")
            inRelease = try container.decodeIfPresent("inRelease")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(ignoreCount, forKey: "ignoreCount")
            try container.encodeIfPresent(ignoreDuration, forKey: "ignoreDuration")
            try container.encodeIfPresent(ignoreUserCount, forKey: "ignoreUserCount")
            try container.encodeIfPresent(ignoreUserWindow, forKey: "ignoreUserWindow")
            try container.encodeIfPresent(ignoreWindow, forKey: "ignoreWindow")
            try container.encodeIfPresent(inCommit, forKey: "inCommit")
            try container.encodeIfPresent(inNextRelease, forKey: "inNextRelease")
            try container.encodeIfPresent(inRelease, forKey: "inRelease")
          }
        }

        public init(assignedTo: String? = nil, hasSeen: Bool? = nil, ignoreDuration: Int? = nil, isBookmarked: Bool? = nil, isPublic: Bool? = nil, merge: Bool? = nil, status: String? = nil, statusDetails: StatusDetails? = nil) {
          self.assignedTo = assignedTo
          self.hasSeen = hasSeen
          self.ignoreDuration = ignoreDuration
          self.isBookmarked = isBookmarked
          self.isPublic = isPublic
          self.merge = merge
          self.status = status
          self.statusDetails = statusDetails
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          assignedTo = try container.decodeIfPresent("assignedTo")
          hasSeen = try container.decodeIfPresent("hasSeen")
          ignoreDuration = try container.decodeIfPresent("ignoreDuration")
          isBookmarked = try container.decodeIfPresent("isBookmarked")
          isPublic = try container.decodeIfPresent("isPublic")
          merge = try container.decodeIfPresent("merge")
          status = try container.decodeIfPresent("status")
          statusDetails = try container.decodeIfPresent("statusDetails")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encodeIfPresent(assignedTo, forKey: "assignedTo")
          try container.encodeIfPresent(hasSeen, forKey: "hasSeen")
          try container.encodeIfPresent(ignoreDuration, forKey: "ignoreDuration")
          try container.encodeIfPresent(isBookmarked, forKey: "isBookmarked")
          try container.encodeIfPresent(isPublic, forKey: "isPublic")
          try container.encodeIfPresent(merge, forKey: "merge")
          try container.encodeIfPresent(status, forKey: "status")
          try container.encodeIfPresent(statusDetails, forKey: "statusDetails")
        }
      }

      public struct Options {
        /** The slug of the organization the issues belong to. */
        public var organizationSlug: String

        /** The slug of the project the issues belong to. */
        public var projectSlug: String

        /** A list of IDs of the issues to be mutated. This parameter shall be repeated for each issue. It is optional only if a status is mutated in which case an implicit update all is assumed. */
        public var id: Int?

        /** Optionally limits the query to issues of the specified status. Valid values are `"resolved"`, `"unresolved"` and `"ignored"`. */
        public var status: String?

        public init(organizationSlug: String, projectSlug: String, id: Int? = nil, status: String? = nil) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.id = id
          self.status = status
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder: RequestEncoder? = nil) {
        self.body = body
        self.options = options
        super.init(service: BulkMutateaListOfIssues.service) { defaultEncoder in
          try (encoder ?? defaultEncoder).encode(body)
        }
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String, id: Int? = nil, status: String? = nil, body: Body) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, id: id, status: status)
        self.init(body: body, options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(self.options.projectSlug)")
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let id = options.id {
          params["id"] = id
        }
        if let status = options.status {
          params["status"] = status
        }
        return params
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Bulk mutate various attributes on issues.  The list of issues to modify is given through the `id` query parameter.  It is repeated for each issue that should be modified.
       - For non-status updates, the `id` query parameter is required.
       - For status updates, the `id` query parameter may be omitted
       for a batch "update all" query.
       - An optional `status` query parameter may be used to restrict
       mutations to only events with the given status.
       The following attributes can be modified and are supplied as JSON object in the body:
       If any ids are out of scope this operation will succeed without any data mutation. */
      public struct Status200: Model {
        /** Bulk mutate various attributes on issues.  The list of issues to modify is given through the `id` query parameter.  It is repeated for each issue that should be modified.
         - For non-status updates, the `id` query parameter is required.
         - For status updates, the `id` query parameter may be omitted
         for a batch "update all" query.
         - An optional `status` query parameter may be used to restrict
         mutations to only events with the given status.
         The following attributes can be modified and are supplied as JSON object in the body:
         If any ids are out of scope this operation will succeed without any data mutation. */
        public enum Status: String, Codable, Equatable, CaseIterable {
          case resolved
          case unresolved
          case ignored
        }

        public var isPublic: Bool

        public var status: Status

        public var statusDetails: [String: AnyCodable]

        public init(isPublic: Bool, status: Status, statusDetails: [String: AnyCodable]) {
          self.isPublic = isPublic
          self.status = status
          self.statusDetails = statusDetails
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          isPublic = try container.decode("isPublic")
          status = try container.decode("status")
          statusDetails = try container.decodeAny("statusDetails")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(isPublic, forKey: "isPublic")
          try container.encode(status, forKey: "status")
          try container.encodeAny(statusDetails, forKey: "statusDetails")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Bad Input */
      case status400

      /** Forbidden */
      case status403

      /** The requested resource does not exist */
      case status404

      public var success: Status200? {
        switch self {
        case let .status200(response): return response
        default: return nil
        }
      }

      public var response: Any {
        switch self {
        case let .status200(response): return response
        default: return ()
        }
      }

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status400: return 400
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status400: return false
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 400: self = .status400
        case 403: self = .status403
        case 404: self = .status404
        default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
        }
      }

      public var description: String {
        "\(statusCode) \(successful ? "success" : "failure")"
      }

      public var debugDescription: String {
        var string = description
        let responseString = "\(response)"
        if responseString != "()" {
          string += "\n\(responseString)"
        }
        return string
      }
    }
  }
}
