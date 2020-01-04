//
//  APIClient.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import Alamofire

public final class APIClient {
    
    public func request(request: URLRequestConvertible,
                        completion: @escaping (Result<Data>) -> Void) {
        let request = Alamofire.request(request).validate()
        logRequest(request)
        
        request.responseData { response in
            self.logResponse(response)
            completion(response.result)
        }
    }
    
    public func requestItem<T: Decodable>(request: APIRoute,
                                          onCompletion: @escaping (_ result: Result<T>) -> Void) {
        self.request(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    onCompletion(.success(try JSONDecoder().decode(T.self, from: data)))
                } catch {
                    onCompletion(.failure(CustomError.parsingError))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}

private extension APIClient {
    
    func logRequest(_ dataRequest: DataRequest) {
        guard let request = dataRequest.request,
            let url = request.url?.absoluteString else { return }
        
        log.debug("✈ Network Request (Method: \(request.httpMethod ?? "Unknown")) \(url)")
        log.debug("Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody?.prettyPrintedJSON {
            log.debug(body)
        }
    }
    
    func logResponse(_ dataResponse: DataResponse<Data>) {
        guard let response = dataResponse.response,
            let url = response.url?.absoluteString else { return }
        
        log.debug("✈ Network Response (Code: \(response.statusCode)) (Duration: \(String(format: "%.3f", dataResponse.timeline.requestDuration)) s) \(url)")
        
        if let data = dataResponse.value ?? dataResponse.data {
            if let jsonBody = data.prettyPrintedJSON {
                log.debug(jsonBody)
            } else if let anyBody = String(data: data, encoding: .utf8) {
                log.debug(anyBody)
            }
        }
    }
}
