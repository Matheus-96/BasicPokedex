//
//  DetailsViewController.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 21/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTypes: UILabel!
    
    
    //MARK: - Variables
    
    var viewModel : DetailsProtocol?
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOutlets()
        viewModel?.setDetails(handler: { (pokemon) in
            self.labelName.text = pokemon.name
            self.labelTypes.text = pokemon.types
            self.imageView.image = UIImage(data: pokemon.image)
        })
        
    }
    
    //MARK: - Methods
    
    func setUpOutlets(){
        self.imageView.layer.cornerRadius = 170
        self.labelTypes.text = ""
    }

}
