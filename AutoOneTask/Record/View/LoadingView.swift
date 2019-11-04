//
//  LoadingView.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView: UIViewRepresentable {

    var animating: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }

    func updateUIView(_ view: UIActivityIndicatorView, context: Context) {
        if animating {
            view.startAnimating()
        } else {
            view.stopAnimating()
        }
    }
}
