//
//  AboutCanadaModel.swift
//  CanadaInfo
//
//  Created by Vivek John on 01/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation

struct AboutCanadaModel: Decodable {
    
    var title: String?
    var rows: [Row]?

    enum CodingKeys: String, CodingKey {
        case title
        case rows
    }
}

struct Row: Decodable {
    
    var title: String?
    var desc: String?
    var imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case desc = "description"
        case imagePath = "imageHref"
    }
}
