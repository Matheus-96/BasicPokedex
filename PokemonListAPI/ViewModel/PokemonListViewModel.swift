//
//  PokemonListViewModel.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 21/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit

protocol PokemonListProtocol {
    
    func getPokemon( sucess: @escaping () -> Void )
    func countPokemon() -> Int
    func pokemonAtIndex(indexPath : IndexPath) -> String
    func setSelectedPokemon(indexPath : IndexPath)
    func getSelectedPokemon() -> String
    func getId() -> Int
}

class PokemonListViewModel : PokemonListProtocol {
    
    //MARK: - Variables
    
    private var pokemonArray = [Any]()
    private var apiService = APIService()
    private var selectedPokemon:String = ""
    private var pokemonID : Int = 0

    //MARK: - Methods
    
    func getPokemon( sucess: @escaping () -> Void ){
        
        apiService.fetchPokemons { (pokemon) in
            self.pokemonArray = pokemon
            sucess()
        }
        
    }
    
    func countPokemon() -> Int {
        return pokemonArray.count 
    }
    
    func pokemonAtIndex(indexPath : IndexPath) -> String {
        
        let pokemon = pokemonArray[indexPath.row] as! [String:String]
        let namePokemon = pokemon["name"]
        return namePokemon!
    }
    func setSelectedPokemon(indexPath : IndexPath) {
        let pokemon =  pokemonArray[indexPath.row] as! [String:String]
        self.selectedPokemon = pokemon["name"]!
        self.pokemonID = indexPath.row + 1
    }
    
    func getSelectedPokemon() -> String {
        return selectedPokemon
    }
    
    func getId() -> Int{
        return pokemonID
    }
    
}
