import Foundation
import Prch

public extension Teams {
  /**
       Caution: this endpoint may change in the future without notice.

       Return a set of points representing a normalized timestamp and the number of events seen in the period.
   Query ranges are limited to Sentry’s configured time-series resolutions.
       */
  enum RetrieveEventCountsForaTeam {
    public static let service = APIService<Response>(id: "Retrieve Event Counts for a Team", tag: "Teams", method: "GET", path: "/api/0/teams/{organization_slug}/{team_slug}/stats/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team:read"])])

    /** The name of the stat to query `("received", "rejected")`. */
    public enum Stat: String, Codable, Equatable, CaseIterable {
      case received
      case rejected
    }

    /** An explicit resolution to search for (one of `10s`, `1h`, and `1d`). */
    public enum Resolution: String, Codable, Equatable, CaseIterable {
      case _10s = "10s"
      case _1h = "1h"
      case _1d = "1d"
    }

    public final class Request: APIRequest<Response> {
      public struct Options {
        /** The slug of the organization the team belongs to. */
        public var organizationSlug: String

        /** The slug of the team to get. */
        public var teamSlug: String

        /** The name of the stat to query `("received", "rejected")`. */
        public var stat: Stat?

        /** A timestamp to set the start of the query in seconds since UNIX epoch. */
        public var since: DateTime?

        /** A timestamp to set the end of the query in seconds since UNIX epoch. */
        public var until: DateTime?

        /** An explicit resolution to search for (one of `10s`, `1h`, and `1d`). */
        public var resolution: Resolution?

        public init(organizationSlug: String, teamSlug: String, stat: Stat? = nil, since: DateTime? = nil, until: DateTime? = nil, resolution: Resolution? = nil) {
          self.organizationSlug = organizationSlug
          self.teamSlug = teamSlug
          self.stat = stat
          self.since = since
          self.until = until
          self.resolution = resolution
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: RetrieveEventCountsForaTeam.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, teamSlug: String, stat: Stat? = nil, since: DateTime? = nil, until: DateTime? = nil, resolution: Resolution? = nil) {
        let options = Options(organizationSlug: organizationSlug, teamSlug: teamSlug, stat: stat, since: since, until: until, resolution: resolution)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)").replacingOccurrences(of: "{" + "team_slug" + "}", with: "\(self.options.teamSlug)")
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let stat = options.stat?.encode() {
          params["stat"] = stat
        }
        if let since = options.since?.encode() {
          params["since"] = since
        }
        if let until = options.until?.encode() {
          params["until"] = until
        }
        if let resolution = options.resolution?.encode() {
          params["resolution"] = resolution
        }
        return params
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public typealias SuccessType = [[Int]]

      /** Success */
      case status200([[Int]])

      /** Forbidden */
      case status403

      /** Team not found */
      case status404

      public var success: [[Int]]? {
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
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode([[Int]].self, from: data))
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
