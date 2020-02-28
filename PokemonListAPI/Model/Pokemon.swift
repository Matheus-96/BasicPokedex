//
//  Pokemon.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 26/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import Foundation

class Pokemon {
    
    let id : Int
    let name: String
    let image: Data
    var types : String
    let description:String
    let specie : String
    let nationalIndex: String
    
    init (id: Int, name: String, image: Data, types: [String], description: String, specie: String){
        
        self.id = id
        self.name = name
        self.image = image
        
        if types.count == 1 {
            self.types = types[0]
        } else {
            self.types = types[1] + " / " + types[0]
        }
        
        self.description = description
        self.specie = specie
        
        if id > 100 {
            self.nationalIndex = "\(id)"
        } else if id > 9 && id < 100 {
            self.nationalIndex = "0\(id)"
        } else {
            self.nationalIndex = "00\(id)"
        }
        
    }
    
}


