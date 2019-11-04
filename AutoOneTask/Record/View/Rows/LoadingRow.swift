//
//  LoadingRow.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingRow: View {
    
    @State var isAnimating: Bool
    var body: some View {
        HStack {
            Spacer()
            Text("Loading ...")
            LoadingView(animating: isAnimating)
            Spacer()
        }
    }
}
