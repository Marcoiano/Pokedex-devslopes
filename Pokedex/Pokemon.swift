//
//  Pokemon.swift
//  Pokedex
//
//  Created by Marco Tabacchino on 19/07/16.
//  Copyright © 2016 Marco Tabacchino. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionID: String!
    private var _nexEvolutionLvl: String!
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    var pokedexID: Int {
        return _pokedexID
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type =  ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionLvl: String {
        if _nexEvolutionLvl == nil {
            _nexEvolutionLvl = ""
        }
        return _nexEvolutionLvl
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        print("chiamato")
        print(_pokemonURL)
        let url = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String, let height = dict["height"] as? String, let attack = dict["attack"] as? Int, let defense = dict["defense"] as? Int {
                    
                    self._weight = weight
                    self._height = height
                    self._attack = "\(attack)"
                    self._defense = "\(defense)"
                    
                    
                    print(self._weight)
                    print(self._height)
                    print(self._attack)
                    print(self._defense)
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                        
                    }
                } else {
                    self._type = ""
                }
                
                print(self._type)
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0{
                    
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let result = response.result
                            if let descDict = result.value as? Dictionary<String, AnyObject> , let description = descDict["description"] as? String {
                                self._description = description
                                print(self._description)
                            }
                            completed()
                        }
                    }
                    
                    
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String, let lvl = evolutions[0]["level"] as? Int {
                        
                        //Mega is not found
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionID = num
                                self._nextEvolutionTxt = to
                                self._nexEvolutionLvl = "\(lvl)"
                                
                                print(self._nextEvolutionID)
                                print(self._nextEvolutionTxt)
                                print(self._nexEvolutionLvl)
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
    
}