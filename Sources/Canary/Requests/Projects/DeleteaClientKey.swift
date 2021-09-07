//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import Prch


extension Projects {

    /** Delete a client key. */
    public enum DeleteaClientKey {

        public static let service = APIService<Response>(id: "Delete a Client Key", tag: "Projects", method: "DELETE", path: "/api/0/projects/{organization_slug}/{project_slug}/keys/{key_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:admin"])])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** The slug of the organization the client keys belong to. */
                public var organizationSlug: String

                /** The slug of the project the client keys belong to. */
                public var projectSlug: String

                /** The ID of the key to delete. */
                public var keyId: String

                public init(organizationSlug: String, projectSlug: String, keyId: String) {
                    self.organizationSlug = organizationSlug
                    self.projectSlug = projectSlug
                    self.keyId = keyId
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: DeleteaClientKey.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(organizationSlug: String, projectSlug: String, keyId: String) {
                let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, keyId: keyId)
                self.init(options: options)
            }

            public override var path: String {
                return super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(self.options.projectSlug)").replacingOccurrences(of: "{" + "key_id" + "}", with: "\(self.options.keyId)")
            }
        }

        public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
            public typealias SuccessType = Void

            /** Success */
            case status204

            /** Forbidden */
            case status403

            /** Project not found */
            case status404

            public var success: Void? {
                switch self {
                case .status204: return ()
                default: return nil
                }
            }

            public var response: Any {
                switch self {
                default: return ()
                }
            }

            public var statusCode: Int {
                switch self {
                case .status204: return 204
                case .status403: return 403
                case .status404: return 404
                }
            }

            public var successful: Bool {
                switch self {
                case .status204: return true
                case .status403: return false
                case .status404: return false
                }
            }

            public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
                switch statusCode {
                case 204: self = .status204
                case 403: self = .status403
                case 404: self = .status404
                default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
                }
            }

            public var description: String {
                return "\(statusCode) \(successful ? "success" : "failure")"
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
