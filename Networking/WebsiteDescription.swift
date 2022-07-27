//
//  WebsiteDescription.swift
//  Networking
//
//  Created by Артур Дохно on 27.07.2022.
//

import Foundation

struct WebsiteDescription: Codable {
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
