//
//  EndPoint.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

enum HTTPMethodType: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
}

extension Requestable {
    private func makeURL(query: [String:String], networkConfig: NetworkConfiguration) throws -> URL {
        let baseURL = networkConfig.baseURL.absoluteString.last != "/" ? networkConfig.baseURL.absoluteString.appending("/") : networkConfig.baseURL.absoluteString
        let endpoint = baseURL.appending(path)
        guard var urlComponents = URLComponents(string: endpoint) else { throw NetworkError.url }
        var queryItems: [URLQueryItem] = []
        queryItems += networkConfig.queryParameter.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems += query.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { throw NetworkError.url }
        return url
    }
    
    func makeURLRequest(networkConfig: NetworkConfiguration ,query: [String:String] = [:], body: [String:String] = [:]) throws -> URLRequest {
        let url = try self.makeURL(query: query, networkConfig: networkConfig)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = networkConfig.header
        if !body.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}

protocol Responsable {
    associatedtype responseType
    
    var decoder: ResponseDecoder { get }
}

protocol ResponseDecoder {
    func decode<T: Decodable>(data: Data) throws -> T
}

class JSONResponseDecoder: ResponseDecoder {
    private let decoder = JSONDecoder()
    
    func decode<T: Decodable>(data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}

protocol Networable: Requestable, Responsable {}

struct EndPoint<T>: Networable {
    
    typealias responseType = T
    
    let path: String
    let method: HTTPMethodType
    let decoder: ResponseDecoder
    
    init(path: String, method: HTTPMethodType) {
        self.path = path
        self.method = method
        self.decoder = JSONResponseDecoder()
    }
}
