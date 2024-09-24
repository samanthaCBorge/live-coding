//
//  Pokemon.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import Foundation

struct Response: Codable, Hashable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Hashable {
    let name: String
    let url: String
}

struct PokemonInfo: Codable, Hashable {
    let id: Int
    let name: String
    let baseExperience: Int
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case sprites
    }
}

struct Sprites: Codable, Hashable {
    let frontDefault: String
    let frontShiny: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
