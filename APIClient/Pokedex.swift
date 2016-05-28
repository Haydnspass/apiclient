//
//  Pokedex.swift
//  APIClient
//
//  Created by Nils Fischer on 20.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy


/// A Pokedex contains the Pokemon species encountered in a specific region of the Pokemon world
struct Pokedex: JSONDecodable {
    
    /// The name of the resource, such as "kanto"
    let name: String
    /// The localized name of the Pokedex, containing the name of the region such as "Kanto"
    let localizedName: String
    /// The numbered entries of the Pokedex
    let entries: [Entry]
    
    struct Entry: JSONDecodable {
        
        let number: Int
        let pokemonSpecies: NamedResource<PokemonSpecies>
        
        init(json: JSON) throws {
            self.number = try json.int("entry_number")
            self.pokemonSpecies = try json.decode("pokemon_species")
        }
    }
    
    init(json: JSON) throws {
        self.name = try json.string("name")
        self.localizedName = try json.localized("names").string("name")
        self.entries = try json.arrayOf("pokemon_entries")
    }
    
}
