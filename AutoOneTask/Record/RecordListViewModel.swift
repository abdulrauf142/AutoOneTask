//
//  RecordListViewModel.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class RecordListViewModel: ObservableObject {
    
    
    // MARK: - Properties
    @Published private var page: RecordPage?
    @Published var errorMessage = ""
    @Published var isErrorShown = false
    
    private var cancellable: [AnyCancellable] = []
    private let usecase: RecordUsecaseType
    private let errorSubject = PassthroughSubject<NetworkError, Never>()

    var rowsCount: Int {
        page?.records.count ?? 0
    }
    
    var canFetchNextPage: Bool {
        (page?.count ?? 0) > (page?.current ?? 0)
    }
    
    var nextPage: Int {
        (page?.current ?? 0) + 1
    }
    // MARK: - Intializer
    init(with usecase: RecordUsecaseType) {
        self.usecase = usecase
    }
    
    // MARK: - Functions
    func object(at index: Int) -> Record? {
        page?.records[index]
    }
    
    func isLastIndex(_ index: Int) -> Bool {
        index >= (page?.records.count ?? 0) - 1
    }

    func fetchPage(for index: Int, model: String? = nil) {
        let cancelable = usecase.fetch(for: index, model: model)
            .catch { error -> Empty<RecordPage, Never> in
                DispatchQueue.main.async { self.errorSubject.send(error) }
                return .init()
             }
            .map { response -> RecordPage in
                
                var manufacturerResponse = response
                manufacturerResponse.records = (self.page?.records ?? []) + response.records
                return manufacturerResponse
            }
            .receive(on: RunLoop.main)
            .assign(to: \.page, on: self)
        
        bindOutputs()
        cancellable += [cancelable]
    }
    
    private func bindOutputs() {
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                (error.errorDescription ?? "KEY_NETWORK_ERROR")
            }
            .receive(on: RunLoop.main)
            .assign(to: \.errorMessage, on: self)
        
        
        let errorStream = errorSubject
        .map { _ in true }
        .assign(to: \.isErrorShown, on: self)
        
        cancellable += [errorMessageStream, errorStream]
    }
}
