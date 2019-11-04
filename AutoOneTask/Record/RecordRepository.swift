//
//  RecordRepository.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import Combine

protocol RecordRepositoryType {
    func fetchRecords(with query: Query) -> AnyPublisher<RecordResponse, NetworkError>
}

struct RecordRepository: RecordRepositoryType {

    // MARK:- Properties
    private let networkManager: Fetchable
    
    // MARK:- Initializers
    init(with networkManager: Fetchable = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK:- Functions
    func fetchRecords(with query: Query) -> AnyPublisher<RecordResponse, NetworkError> {
        networkManager.fetch(from: RecordEndPoint(with: query))
    }
}
