//
//  Sections.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-20.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation
import UIKit

struct HeaderInfo {
    var image: UIImage
    var name: String
    var location: String
}

struct BodyInfo {
    var headline: String
    var main: String
    var time: String
}

enum DataSourceItemType {
    case header(HeaderInfo)
    case work(BodyInfo)
    case education(BodyInfo)
    case announcement(BodyInfo)
}

struct SectionHeader {
    var title: String
    var image: UIImage
}

struct DataSourceItem {
    var identifer: String
    var itemType: DataSourceItemType
}

enum Section {
    case vertical(SectionHeader?, [DataSourceItem])
}
