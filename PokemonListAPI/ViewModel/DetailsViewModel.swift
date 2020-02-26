//
//  DetailsViewModel.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 21/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import Foundation

protocol DetailsProtocol {
    func setDetails (handler :@escaping (Data, String) -> Void )
}

class DetailsViewModel : DetailsProtocol {
    
    //MARK: - Variables
    
//    private var image : String
    private var name : String
    private var pokemonID: Int
    var apiService = APIService()
    
    //MARK: - Init
    
    init(name: String, pokemonID :Int) {
//        self.image = image
        self.name = name
        self.pokemonID = pokemonID
    }
    
    
    //MARK: - Methods
    
    func setDetails (handler :@escaping (Data, String) -> Void ){
        apiService.fetchImage(pokemonIndex: pokemonID) { (data) in
            let imageData = data
            handler(imageData, self.name)
        }
        
        
    }
    
}
