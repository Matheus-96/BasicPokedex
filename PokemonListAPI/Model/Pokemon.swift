//
//  Pokemon.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 26/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import Foundation

class Pokemon {
    
    let name: String
    let image: Data
    var types : String
    let description:String
    let specie : String
    
    init (name: String, image: Data, types: [String], description: String, specie: String){
        self.name = name
        self.image = image
        
        if types.count == 1 {
            self.types = types[0]
        } else {
            self.types = types[1] + " / " + types[0]
        }
        
        self.description = description
        self.specie = specie
        
    }
    
}


