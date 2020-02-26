//
//  APIService.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 21/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import Foundation
import Alamofire


class APIService {
    
    let urlPokemons = "https://pokeapi.co/api/v2/pokemon?limit=807%27"
    
    func fetchPokemons(sucess: @escaping ( [Any]) -> () ) {
        
        Alamofire.request(urlPokemons).responseJSON { (response) in
            
            guard let data = response.data else {return}
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            guard let value = json else {return}
            if let pokemons = value["results"] as? [Any] {
                DispatchQueue.main.async {
                    sucess(pokemons)
                }
                
            }
        }
        
    }
    
    func fetchPokemonInfo(pokemonIndex: Int, sucess: @escaping ([Any]) -> () ) {
        
        let urlPokemon = "https://pokeapi.co/api/v2/pokemon/\(pokemonIndex)/"
        
        Alamofire.request(urlPokemon).responseJSON { (response) in
            guard let data = response.data else {return}
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            guard let infos = json else {return}
            if let types = infos["types"] as? [Any] {
                DispatchQueue.main.async {
                    sucess(types)
                }
            }
            
        }
        
    }
    
    func fetchImage(pokemonIndex : Int, sucess : @escaping (Data) -> Void ){
        
        let urlImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonIndex).png"
        
        DispatchQueue.main.async {
            Alamofire.request(urlImage).responseData { (responseData) in
                guard let imageData = responseData.data else {return}
                
                sucess(imageData)
            }
        }
        
        
    }
    
}
