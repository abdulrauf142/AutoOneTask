//
//  NetworkManager.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 02/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import Combine

protocol Fetchable {
    func fetch<T>(from endpoint: T) -> AnyPublisher<T.Response, NetworkError> where T: EndPoint
}

struct NetworkManager: Fetchable {

    private let session: URLSession
    
    init(with session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetch<T>(from endpoint: T) -> AnyPublisher<T.Response, NetworkError> where T: EndPoint {
        
        guard let request = try? endpoint.buildRequest() else {
            return Future<T.Response, NetworkError> { promise in
                promise(.failure(.nilRequest))
            }.eraseToAnyPublisher()
        }
        let decorder = JSONDecoder()
        return session.dataTaskPublisher(for: request)
            .map {
                $0.data
            }
            .mapError { _ in NetworkError.unknowError }
            .decode(type: T.Response.self, decoder: decorder)
            .mapError { error in
                NetworkError.parseError
            }
            .eraseToAnyPublisher()
    }
}
