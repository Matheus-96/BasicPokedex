//
//  ExtensionStringProtocol.swift
//  PokemonListAPI
//
//  Created by Matheus Rodrigues Araujo on 26/02/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
