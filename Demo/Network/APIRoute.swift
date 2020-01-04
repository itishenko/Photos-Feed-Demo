//
//  APIRoute.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import Alamofire


public protocol APIRoute: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
}

public extension APIRoute {
    
    func encoded(path: String, parameters: [String: Any]) throws -> URLRequest {
        
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try self.encoding.encode(urlRequest as URLRequest, with: parameters)
    }
}

enum DemoAPI: APIRoute {
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    case photos(parameters: [String:Any])
    case user(userId: String)
    case albums(albumId: String)
    case comments(photoId: String)
    
    var method: HTTPMethod {
        
        switch self {
        case .photos: return .get
        case .user: return .get
        case .albums: return .get
        case .comments: return .get
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
        if self.method == .get || self.method == .delete {
            return URLEncoding.default
        }
        return JSONEncoding.default
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let result: (path: String, parameters: [String:Any]) = {
            
            switch self {
            case .photos(let parameters): return ("photos", parameters)
            case .user(let userId): return("user/\(userId)", [:])
            case .albums(let albumId): return ("albums/\(albumId)", [:])
            case .comments(let photoId): return ("photos/\(photoId)/comments", [:])
            }
        }()
        
        return try self.encoded(path: result.path, parameters: result.parameters)
    }
}
