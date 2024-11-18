//
//  General_info_arrow.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 12/11/24.
//

import SwiftUI

struct GeneralInfoItem: Codable, Identifiable {
    let id: Int
    let title: String
    let detailText: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case detailText
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        detailText = try container.decode(String.self, forKey: .detailText)
    }
}
