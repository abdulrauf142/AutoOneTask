//
//  CarModelList.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import SwiftUI

struct CarModelList: View {
    
    @ObservedObject var viewModel = RecordListViewModel(with: RecordUsecase())
    let record: Record
    
       var body: some View {
           
           List {
                   ForEach(0..<self.viewModel.rowsCount, id: \.self) { index in
                      RowBuilder.row(with: self.viewModel.object(at: index), onAppear: self.getCompletion(for: index))
                   }
                   
                   if self.viewModel.canFetchNextPage {
                       LoadingRow(isAnimating: true)
                   }
            
               }.alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                   Alert(title: Text(LocalizedStringKey("Error")), message: Text(LocalizedStringKey(viewModel.errorMessage)))
               })
               .onAppear { self.viewModel.fetchPage(for: 0, model: self.record.id) }
               .navigationBarTitle(LocalizedStringKey("KEY_TITLE_CAR_MODEL_LIST")) 
               .foregroundColor(Color.blue)
       }
    
    private func getCompletion(for index: Int) -> (()->Void)? {
        
        var completion: (() -> Void)? = nil
        if viewModel.isLastIndex(index) {
            completion = { self.viewModel.fetchPage(for: self.viewModel.nextPage, model: self.record.id) }
        }
        return completion
    }
}

struct CarModelList_Previews: PreviewProvider {
    static var previews: some View {
        CarModelList(record: Record(id: "Toyota", name: "Toyota"))
    }
}
