//
//  ErrorModel.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import Foundation

struct FailModel: Codable {
    let response, error: String

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}
