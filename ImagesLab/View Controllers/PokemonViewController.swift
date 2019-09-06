//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/6/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var cards = [Cards]() {
        didSet {
            DispatchQueue.main.async {
                self.pokemonTableView.reloadData()
            }
        }
    }
    
    var cardSearchResult: [Cards] {
        get {
            guard let searchString = searchString else {return cards}
            guard  searchString != "" else {return cards}
            return filterCards(containing: searchString, arr: cards)
        }
    }
    
    var searchString: String? = nil {
        didSet {
            DispatchQueue.main.async {
                self.pokemonTableView.reloadData()
            }
        }
    }

    private func loadData() {
        DispatchQueue.main.async {
            PokemonCards.getCards { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let cards):
                    self.cards = cards
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PokeCardDetailViewController, let indexPath = pokemonTableView.indexPathForSelectedRow else {return}
        destination.pokemonCard = cardSearchResult[indexPath.row]
    }

}

extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokeCardCell", for: indexPath) as? PokeCardTableViewCell else {return UITableViewCell()}
        let aCard = cardSearchResult[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: aCard.imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.pokeCardImage.image = image
                }
            }
        }
        return cell
    }
}

extension PokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
}
