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
        DispatchQueue.main.async {
            
        }
        apiService.fetchPokemonInfo(pokemonIndex: pokemonID) { (array) in
            
            var types: [String] = []
            for element in array {
                let dicionary = element as? [ String: Any ]
                let aux = dicionary?["type"] as? [String:String]
                let type = aux!["name"]! as String
                types.append(type.firstUppercased)
            }
            print(types)
            self.apiService.fetchImage(pokemonIndex: self.pokemonID) { (data) in
                self.pokemon = Pokemon(name: self.name.firstUppercased, image: data, types: types)
                handler(self.pokemon!)
            }
            
            
        }
        
        
    }
    
}
