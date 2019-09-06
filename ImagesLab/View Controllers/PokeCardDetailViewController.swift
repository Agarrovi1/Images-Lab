//
//  PokeCardDetailViewController.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/6/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class PokeCardDetailViewController: UIViewController {
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var weaknessLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    var pokemonCard: Cards?
    
    private func loadImage() {
        guard let pokemonCard = pokemonCard else {return}
        let hiResUrl = pokemonCard.imageUrlHiRes
        ImageHelper.shared.fetchImage(urlString: hiResUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromUrl):
                    self.cardImage.image = imageFromUrl
                }
            }
        }
    }
    private func loadWeakness() {
        guard let pokemonCard = pokemonCard else {return}
        if let weakness = pokemonCard.weaknesses {
            weaknessLabel.text = "Weakness: \(weakness[0].type) \(weakness[0].value)"
        } else {
            weaknessLabel.text = ""
        }
    }
    private func loadTypes() {
        guard let pokemonCard = pokemonCard else {return}
        
        if let types = pokemonCard.types {
            if types.count > 1 {
                let typeString = types.reduce("") { (result, a:String) in
                    "\(result), \(a)"
                }
                typeLabel.text = "Type: \(pokemonCard.supertype), \(pokemonCard.subtype), \(typeString)"
                
            } else {
                let typeString = types[0]
                typeLabel.text = "Type: \(pokemonCard.supertype), \(pokemonCard.subtype), \(typeString)"
            }
        } else {
            typeLabel.text = "Type: \(pokemonCard.supertype), \(pokemonCard.subtype)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemonCard = pokemonCard else {return}
        loadImage()
        loadWeakness()
        setLabel.text = pokemonCard.set
        nameLabel.text = pokemonCard.name
        loadTypes()
    }

}
