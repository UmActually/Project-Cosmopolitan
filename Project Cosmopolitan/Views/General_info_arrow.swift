//
//  General_info_arrow.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 12/11/24.
//

import SwiftUI

struct ArrowItem: Identifiable {
    let id = UUID()
    let title: String
    let detailText: String
    var isExpanded: Bool = false
}
