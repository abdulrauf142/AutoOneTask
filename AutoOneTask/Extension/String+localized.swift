//
//  String+localized.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 02/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation

extension String {
    var localized: String { return NSLocalizedString(self, comment: "") }
}
