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
    
    
    //MARK: - Variables
    
    var viewModel : DetailsProtocol?
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.setDetails(handler: { (imageData, name) in
            self.labelName.text = name
            
            let image = UIImage(data: imageData)
            self.imageView.image = image
        })
        
    }
    
    //MARK: - Methods

}
