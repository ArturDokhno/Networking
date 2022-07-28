//
//  Course.swift
//  Networking
//
//  Created by Артур Дохно on 27.07.2022.
//

import Foundation

struct Course: Codable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
