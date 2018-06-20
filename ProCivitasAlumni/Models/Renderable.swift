//
//  Renderable.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-19.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation

protocol Renderable: class {
    func render(with item: DataSourceItemType)
    func render(with header: SectionHeader)
}
