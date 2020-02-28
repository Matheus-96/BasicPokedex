//
//  DetailsViewModel.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 21/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import Foundation

protocol DetailsProtocol {
    func setDetails (handler :@escaping (Pokemon) -> Void )
}

class DetailsViewModel : DetailsProtocol {
    
    //MARK: - Variables
    
    private var name: String
    private var pokemon : Pokemon?
    private var pokemonID: Int
    var apiService = APIService()
    var data : Data?
    
    //MARK: - Init
    
    init(name: String, pokemonID :Int) {
        self.name = name
        self.pokemonID = pokemonID
    }
    
    
    //MARK: - Methods
    
    func setDetails (handler :@escaping (Pokemon) -> Void ){
        apiService.fetchPokemonInfo(pokemonIndex: pokemonID) { (array) in
            let types = self.retriveTypes(array: array)
            
            self.apiService.fetchImage(pokemonIndex: self.pokemonID) { (data) in
                let imageData = data
                
                self.apiService.fetchPokedexEntry(pokemonIndex: self.pokemonID) { (dictionary, species) in
                    let specie = self.retriveSpecie(species: species)
                    let description = self.retrivePokedexText(dictionary: dictionary)
                    
                    self.pokemon = Pokemon(id: self.pokemonID, name: self.name.firstUppercased, image: imageData, types: types, description: description, specie: specie)
                    handler(self.pokemon!)
                }
            }
        }
    }
    
    //MARK: - Private Methods
    
    private func retriveTypes(array: [Any] ) -> [String] {
        
        var types: [String] = []
        for element in array {
            let dicionary = element as? [ String: Any ]
            let aux = dicionary?["type"] as? [String:String]
            let type = aux!["name"]! as String
            types.append(type.firstUppercased)
        }
        return types
    }
    
    private func retrivePokedexText(dictionary: [[String: Any]]) -> String {
        for element in dictionary {
            let language = element["language"] as! [String:String]
            let idiom = language["name"]
            if idiom == "en" {
                var description = element["flavor_text"] as! String
                description = description.replacingOccurrences(of: "\n", with: " ", options: NSString.CompareOptions.literal, range: nil)
                return description
            }
        }
        return ""
    }
    
    private func retriveSpecie(species: [[String:Any]]) -> String {
        for dicionary in species {
            let language = dicionary["language"] as! [String:Any]
            let idiom = language["name"] as! String
            if idiom == "en"{
                return dicionary["genus"] as! String
            }
        }
        return ""
    }
    
}
