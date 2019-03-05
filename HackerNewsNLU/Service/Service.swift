//
//  Service.swift
//  HackerNewsNLU
//
//  Created by Leonardo Oliveira on 04/03/19.
//  Copyright © 2019 Leonardo Oliveira. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
}

public protocol Service {
    
    var endpoint: String { get }
    var jsonDecoder: JSONDecoder { get set }
    
}

extension Service {
    
    var baseURL: URL {
        return URL(string: "https://api.us-south.apiconnect.appdomain.cloud/leonardorockicloudcom-dev/sb/harckernews/")!
    }
    
    var headers: [String : String] {
        return ["x-ibm-client-id": "91c5a0b0-a395-42a7-a5d1-91edd96461f6",
                "accept": "application/json"]
    }
    
    var resourceURL: URL {
        return baseURL.appendingPathComponent(endpoint)
    }
    
    func request<T: Codable>(url: URL, method: HTTPMethod = .get, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void, completion: @escaping () -> Void) {
        let session = URLSession(configuration: .default)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        let datatask = session.dataTask(with: urlRequest) { (data, response, error) in
            session.finishTasksAndInvalidate()
            defer { DispatchQueue.main.async { completion() } }
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
                return
            }
            do {
                let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    success(decodedResponse)
                }
            } catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }
        datatask.resume()
    }
    
}
