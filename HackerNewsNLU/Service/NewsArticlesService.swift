//
//  NewsArticlesService.swift
//  HackerNewsNLU
//
//  Created by Leonardo Oliveira on 04/03/19.
//  Copyright © 2019 Leonardo Oliveira. All rights reserved.
//

import Foundation

public class NewsArticlesService: Service {
    
    public var endpoint: String = "update"
    
    public lazy var jsonDecoder = JSONDecoder()
    
    public func fetchArticles(success: @escaping ([NewsArticles]) -> Void, failure: @escaping (Error) -> Void, completion: @escaping () -> Void) {
        request(url: resourceURL, success: success, failure: failure, completion: completion)
    }
    
}
