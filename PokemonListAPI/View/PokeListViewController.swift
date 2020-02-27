//
//  PokeListViewController.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 27/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit

class PokeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    let viewModel : PokemonListProtocol = PokemonListViewModel()
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon List"
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.getPokemon {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.searchPokemon(text: "")
        searchBar.text = ""
        self.tableView.reloadData()
    }
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countPokemon()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let name = viewModel.pokemonAtIndex(indexPath: indexPath)
        cell.textLabel?.text = name.firstUppercased
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = viewModel.pokemonAtIndex(indexPath: indexPath)
        viewModel.setNewId(name: name)
        viewModel.setSelectedPokemon(indexPath: indexPath)
        performSegue(withIdentifier: "details", sender: nil)
    }
    
    //MARK: - Search Bar Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            viewModel.searchPokemon(text: text)
            self.tableView.reloadData()
        }
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
