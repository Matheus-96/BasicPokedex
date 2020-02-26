//
//  PokemonListTableViewController.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 21/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit

class PokemonListTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    
    //MARK: - Variables
    
    let viewModel : PokemonListProtocol = PokemonListViewModel()
    var searchController = UISearchBar(frame: CGRect(x: 0, y: 0, width: 1, height: 50))
    
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon List"
        
        searchController.delegate = self
        self.tableView.tableHeaderView = searchController
        
        viewModel.getPokemon {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.searchPokemon(text: "")
        searchController.text = ""
        self.tableView.reloadData()
    }
    
    //MARK: - Search bar methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchController.text {
            print(text)
            viewModel.searchPokemon(text: text)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table View Methods


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countPokemon()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let name = viewModel.pokemonAtIndex(indexPath: indexPath)
        cell.textLabel?.text = name.firstUppercased

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = viewModel.pokemonAtIndex(indexPath: indexPath)
        viewModel.setNewId(name: name)
        viewModel.setSelectedPokemon(indexPath: indexPath)
        performSegue(withIdentifier: "details", sender: nil)
        
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "details" {
            let details = segue.destination as? DetailsViewController
            let pokemon = viewModel.getSelectedPokemon()
            let id = viewModel.getId()
            let detailsViewModel = DetailsViewModel(name: pokemon, pokemonID: id )
            details?.viewModel = detailsViewModel
        }
        
    }

}
