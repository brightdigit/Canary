import Foundation
import Prch

public extension Projects {
  /**
       Caution
   This endpoint may change in the future without  notice.

       Return a set of points representing a normalized timestamp and the
   number of events seen in the period.
   Query ranges are limited to Sentry's configured time-series resolutions.
       */
  enum RetrieveEventCountsForaProject {
    public static let service = Service<Response>(id: "Retrieve Event Counts for a Project", tag: "Projects", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/stats/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    /** The name of the stat to query `("received", "rejected", "blacklisted", "generated")`. */
    public enum Stat: String, Codable, Equatable, CaseIterable {
      case received
      case rejected
      case blacklisted
      case generated
    }

    /** An explicit resolution to search for (one of `10s`, `1h`, and `1d`). */
    public enum Resolution: String, Codable, Equatable, CaseIterable {
      case _10s = "10s"
      case _1h = "1h"
      case _1d = "1d"
    }

    public struct Request: ServiceRequest {
      public var service: Service<ResponseType> {
        return RetrieveEventCountsForaProject.service
      }

      public typealias ResponseType = Response

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The slug of the project. */
        public var projectSlug: String

        /** The name of the stat to query `("received", "rejected", "blacklisted", "generated")`. */
        public var stat: Stat?

        /** A timestamp to set the start of the query in seconds since UNIX epoch. */
        public var since: Date?

        /** A timestamp to set the end of the query in seconds since UNIX epoch. */
        public var until: Date?

        /** An explicit resolution to search for (one of `10s`, `1h`, and `1d`). */
        public var resolution: Resolution?

        public init(organizationSlug: String, projectSlug: String, stat: Stat? = nil, since: Date? = nil, until: Date? = nil, resolution: Resolution? = nil) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.stat = stat
          self.since = since
          self.until = until
          self.resolution = resolution
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, stat: Stat? = nil, since: Date? = nil, until: Date? = nil, resolution: Resolution? = nil) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, stat: stat, since: since, until: until, resolution: resolution)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)")
      }

      public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let stat = options.stat?.encode() {
          params["stat"] = stat
        }
        if let since = options.since?.encode(with: CanaryAPI.dateEncodingFormatter) {
          params["since"] = since
        }
        if let until = options.until?.encode(with: CanaryAPI.dateEncodingFormatter) {
          params["until"] = until
        }
        if let resolution = options.resolution?.encode() {
          params["resolution"] = resolution
        }
        return params
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<[[Int]], Void> {
        switch self {
        case let .status200(response):
          return .success(response)

        default:
          return .defaultResponse(statusCode, ())
        }
      }

      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      public typealias SuccessType = [[Int]]

      /** Success */
      case status200([[Int]])

      /** Forbidden */
      case status403

      public var success: [[Int]]? {
        switch self {
        case let .status200(response): return response
        default: return nil
        }
      }

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status403: return 403
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode([[Int]].self, from: data))
        case 403: self = .status403
        default: throw ClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
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
