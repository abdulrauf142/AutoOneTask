//
//  RecordUsecase.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import Combine

protocol RecordUsecaseType {
    func fetch(for index: Int, model: String?) -> AnyPublisher<RecordPage, NetworkError>
}

struct RecordUsecase: RecordUsecaseType {
    
    // MARK:- Properties
    private let repository: RecordRepositoryType
    
    // MARK:- Initializers
    init(with repository: RecordRepositoryType = RecordRepository()) {
        self.repository = repository
    }
    // MARK:- Initializers
    func fetch(for index: Int, model: String?) -> AnyPublisher<RecordPage, NetworkError> {
        return repository.fetchRecords(with: query(with: index, model: model))
                                        .tryMap { RecordPage(with: $0) }
                                        .mapError { _ in NetworkError.transformError }
                                        .eraseToAnyPublisher()
    }
    
    func query(with index: Int, model: String? = nil) -> Query {
        Query(type:  model == nil ? .manufacturer : .carModel, page: index, pageSize: 20, model: model)
    }
}
