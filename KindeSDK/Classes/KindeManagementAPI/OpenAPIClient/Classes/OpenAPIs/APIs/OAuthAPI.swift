//
// OAuthAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


open class OAuthAPI {

    /**
     Returns the details of the currently logged in user
     
     - returns: UserProfile
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func getUser() async throws -> UserProfile {
        return try await getUserWithRequestBuilder().execute().body
    }

    /**
     Returns the details of the currently logged in user
     - GET /oauth2/v2/user_profile
     - Contains the id, names and email of the currently logged in user 
     - BASIC:
       - type: http
       - name: kindeBearerAuth
     - returns: RequestBuilder<UserProfile> 
     */
    open class func getUserWithRequestBuilder() -> RequestBuilder<UserProfile> {
        let localVariablePath = "/oauth2/v2/user_profile"
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<UserProfile>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }
}
