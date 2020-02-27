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
    func searchPokemon(text: String)
    func setNewId(name: String)
}

class PokemonListViewModel : PokemonListProtocol {
    
    //MARK: - Variables
    
    private var pokemonArray = [String]()
    private var apiService = APIService()
    private var selectedPokemon:String = ""
    private var pokemonID : Int = 0
    
    private var pokeArray = [String]()

    //MARK: - Methods
    
    func getPokemon( sucess: @escaping () -> Void ){
        
        apiService.fetchPokemons { (pokemon) in
            self.createArrayPokemons(array: pokemon)
            sucess()
        }
    }
    
    func createArrayPokemons(array: [Any]){
        
        var pokemons = [String]()
        let arrayDic = array as! Array<[String:String]>
        for element in arrayDic{
            let poke = element["name"]
            pokemons.append(poke!)
        }
        self.pokeArray = pokemons
//        print(pokemons)
        self.searchPokemon()
    }
    
    func countPokemon() -> Int {
        return pokemonArray.count 
    }
    
    func pokemonAtIndex(indexPath : IndexPath) -> String {
        let pokemon = pokemonArray[indexPath.row]
        return pokemon
    }
    
    func setSelectedPokemon(indexPath : IndexPath) {
        let pokemon =  pokemonArray[indexPath.row]
        self.selectedPokemon = pokemon
    }
    
    func getSelectedPokemon() -> String {
        return selectedPokemon
    }
    
    func getId() -> Int{
        return pokemonID
    }
    
    func searchPokemon(text: String = ""){
        
        if text != ""{
            pokemonArray = pokeArray.filter { (aux:String) -> Bool in
                return aux.range(of: text, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        } else {
            pokemonArray = pokeArray
        }
    }
    
    func setNewId(name: String){
        let index = pokeArray.firstIndex(of: name)!
        self.pokemonID = index + 1
        
    }
    
}
