/**
  A thin client for accessing the Kinde Management API.
 
  Note: an access token for the authorized user is set as a custom header in `OpenAPIClientAPI` before each call due to the Bearer security declaration in the API specification
  not being exposed as a parameter in the OpenAPI generatated requests (an apparent bug).
 */
public class KindeManagementApiClient {
    private static var config: Config?
    
    /**
     `configure` must be called before `KindeManagementApiClient` is used.
     
     Set the host of the base URL of the client to the business name extracted from the
     configured `issuer`. E.g., `https://example.kinde.com` -> `example`.
     */
    public static func configure(from source: Config.Source = .plist) {
        config = Config.from(source)
        
        if let issuer = config?.issuer,
           let urlComponents = URLComponents(string: issuer),
           let host = urlComponents.host,
           let businessName = host.split(separator: ".").first {
            OpenAPIClientAPI.basePath = OpenAPIClientAPI.basePath.replacingOccurrences(of: "://app.", with: "://\(businessName).")
        } else {
            preconditionFailure("Failed to parse Business Name from configured issuer \(config?.issuer ?? "")")
        }
    }

    /**
     Get all users subject to the permissions attached to the proviced `accessToken`.
     */
    public static func getUsers(sort: UsersAPI.Sort_getUsers? = nil, pageSize: Int? = nil, userId: Int? = nil, nextToken: String? = nil, accessToken: String, then completion: @escaping ((_ data: Users?, _ error: Error?) -> Void)) {
        OpenAPIClientAPI.customHeaders = [ "Authorization": "Bearer \(accessToken)" ]
        
        UsersAPI.getUsers(sort: sort, pageSize: pageSize, userId: userId, nextToken: nextToken, completion: completion)
    }
    
    /**
     Get the current use associated with the provided `accessToken`.
     */
    public static func getUser(accessToken: String, then completion: @escaping ((_ data: UserProfile?, _ error: Error?) -> Void)) {
        OpenAPIClientAPI.customHeaders = [ "Authorization": "Bearer \(accessToken)" ]
        
        OAuthAPI.getUser(completion: completion)
    }
}
