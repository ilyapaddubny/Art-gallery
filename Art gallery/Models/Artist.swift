//
//  Artist.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 14.02.2024.
//

import Foundation

struct Artist: Codable {
    let name: String
    let bio: String
    let image: String
    let works: [PieceOfArt]
}

struct ArtistsData: Codable {
    let artists: [Artist]
}

