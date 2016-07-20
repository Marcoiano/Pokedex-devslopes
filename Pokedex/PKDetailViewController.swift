//
//  PKDetailViewController.swift
//  Pokedex
//
//  Created by Marco Tabacchino on 20/07/16.
//  Copyright © 2016 Marco Tabacchino. All rights reserved.
//

import UIKit

class PKDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var pokemonImg: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var defenseLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var attackLbl: UILabel!
    
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    @IBOutlet weak var pokedexLbl: UILabel!
    
    @IBOutlet weak var evoLbl: UILabel!
    var pokemon: Pokemon!
    
    init(pokemon: Pokemon) {
        super.init(nibName: "PKDetailViewController", bundle: nil)
        self.pokemon = pokemon
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        pokemonImg.image = UIImage(named: "\(pokemon.pokedexID)")
        pokemon.downloadPokemonDetails { () -> () in
            ///this will be called after download is done
            self.updateUI()
            
        }
        
        
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.attack
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexLbl.text = "\(pokemon.pokedexID)"
        
        
        if pokemon.nextEvolutionID == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        }else{
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvolutionID)")
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            if pokemon.nextEvolutionLvl != ""{
                str += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            evoLbl.text = str
        }
    }
    
    @IBAction func onBackBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}