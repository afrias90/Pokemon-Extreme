//
//  CoreDataHelp.swift
//  Pokemon Extreme
//
//  Created by Adolfo Frias on 3/22/17.
//  Copyright © 2017 Adolfo Frias. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func addAllPokemon() {
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Abra", imageName: "abra")
    createPokemon(name: "Charmander", imageName: "charmander")
    createPokemon(name: "Dratini", imageName: "dratini")
    createPokemon(name: "Jigglypuff", imageName: "jigglypuff")
    createPokemon(name: "Bulbasaur", imageName: "bullbasaur")
    createPokemon(name: "Pikachu", imageName: "pikachu-2")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
}

func createPokemon(name : String, imageName: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemonster = Pokemonster(context: context)
    pokemonster.name = name
    pokemonster.imageName = imageName
    
    
}

func getAllPokemon() -> [Pokemonster] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
        let pokemons = try context.fetch(Pokemonster.fetchRequest()) as! [Pokemonster]
        
        
        if pokemons.count == 0 {
            //to call function once more
            addAllPokemon()
            return getAllPokemon()
        }
        
        return pokemons
    } catch {}
    return []
    
}
