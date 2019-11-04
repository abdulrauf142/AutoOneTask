//
//  RowBuilder.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import SwiftUI

struct RecordRow: View {
    
    let record: Record
    var body: some View {
        Text(record.name)
    }
}


struct RowBuilder {
    
    static func row(with record: Record?, onAppear: (() -> Void)?) -> some View {
        
        guard let record = record else { return AnyView(Text("")) }
        
        var row = AnyView(RecordRow(record: record))
        if let completion = onAppear {
           row = AnyView(RecordRow(record: record)
            .onAppear { completion() } )
        }
        return row
    }
}
