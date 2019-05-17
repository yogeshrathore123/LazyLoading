//
//  APIResults.swift
//  LazyLoading
//
//  Created by Yogesh Rathore on 17/04/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import Foundation

struct APIResults: Decodable {
    let pageNum: Int?
    let pageSize: Int?
    let totalItemsCount: Int?
    let totalPagesCount: Int?
    let contentItems: [User]
    
    enum CodingKeys: String, CodingKey {
        case pageNum = "page"
        case pageSize = "per_page"
        case totalItemsCount = "total"
        case totalPagesCount = "total_pages"
        case contentItems = "data"
    }
}
