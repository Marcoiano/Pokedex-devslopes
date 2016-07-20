//
//  PKViewCell.swift
//  Pokedex
//
//  Created by Marco Tabacchino on 19/07/16.
//  Copyright © 2016 Marco Tabacchino. All rights reserved.
//

import UIKit

class PKViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.layer.cornerRadius = 5.0
//        self.clipsToBounds = true
//    }
//    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }

}
