//
//  EndPoint.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

enum EndpointError: Error {
    case url
}

enum HTTPMethodType: String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct EndPoint {
    
    let path: String
    let method: HTTPMethodType
    let networkConfig: NetworkConfiguration
    
    init(path: String, method: HTTPMethodType, networkConfig: NetworkConfiguration) {
        self.path = path
        self.method = method
        self.networkConfig = networkConfig
    }
    
    private func makeURL(query: [String:String]) throws -> URL {
        let baseURL = networkConfig.baseURL.absoluteString.last != "/" ? networkConfig.baseURL.absoluteString.appending("/") : networkConfig.baseURL.absoluteString
        let endpoint = baseURL.appending(path)
        guard var urlComponents = URLComponents(string: endpoint) else { throw EndpointError.url }
        var queryItems: [URLQueryItem] = []
        queryItems += networkConfig.queryParameter.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems += query.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { throw EndpointError.url }
        return url
    }
    
    func makeURLRequest(query: [String:String] = [:], body: [String:String] = [:]) throws -> URLRequest {
        let url = try self.makeURL(query: query)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = networkConfig.header
        if !body.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}
