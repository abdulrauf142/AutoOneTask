//
//  ManufacturerList.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import SwiftUI

struct ManufacturerList: View {
    
    @ObservedObject var viewModel = RecordListViewModel(with: RecordUsecase())
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(0..<self.viewModel.rowsCount, id: \.self) { index in
                
                    NavigationLink(destination: CarModelList(record: self.viewModel.object(at: index)!)) {
                        RowBuilder.row(with: self.viewModel.object(at: index), onAppear: self.getCompletion(for: index))
                    }
                }
                                  
                if self.viewModel.canFetchNextPage {
                    LoadingRow(isAnimating: true)
                }
                
            }.alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                Alert(title: Text(LocalizedStringKey("Error")), message: Text(LocalizedStringKey(viewModel.errorMessage)))
            })
            .onAppear { self.viewModel.fetchPage(for: 0) }
            .navigationBarTitle(LocalizedStringKey("KEY_TITLE_MANUFACTURER_LIST"))
            .foregroundColor(Color.blue)
        }
    }
    
    private func getCompletion(for index: Int) -> (()->Void)? {
        
        var completion: (() -> Void)? = nil
        if viewModel.isLastIndex(index) {
            completion = { self.viewModel.fetchPage(for: self.viewModel.nextPage) }
        }
        return completion
    }
}

struct ManufacturerList_Previews: PreviewProvider {
    static var previews: some View {
        ManufacturerList()
    }
}
