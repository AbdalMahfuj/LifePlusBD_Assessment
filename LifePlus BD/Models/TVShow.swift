//
//  APIResponse.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//

import Foundation

struct Rating: Codable {
    let average: Float?
}

struct Image: Codable {
    let medium: String?
    let original: String?
}

struct TVShow: Codable {
    let score: Double?
    let details: TVShowDetails?
  
    var imageURL: String? {
        return details?.imageURL
    }
    
    enum CodingKeys: String, CodingKey {
      case score
      case details = "show"
    }
}

struct TVShowDetails: Codable {
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let rating: Rating?
    let runtime: Float?
    let summary: String?
    let image: Image?
  
    var imageURL: String? {
        if let url = image?.medium {
            return url
        } else {
            return image?.original
        }
    }
}
