//
//  HomeModel.swift
//  GS_challenge
//
//  Created by kaushik on 21/03/22.
//

import Foundation

// MARK: - HomeModel

struct HomeModel: Codable {
    let copyright, date, explanation: String?
    let hdurl: String?
    let mediaType, serviceVersion, title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
