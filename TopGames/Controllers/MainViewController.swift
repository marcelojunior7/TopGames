//
//  MainViewController.swift
//  TopGames
//
//  Created by Marcelo on 31/07/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var games = [String]()
    
    class func instance() -> MainViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as! MainViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
//        let character = characters[indexPath.row]
//        cell.labelTitle.text = character.name
//        cell.imageBackground.af_setImage(withURL:URL(string: character.thumbnail?.fullPath() ?? "")!, placeholderImage: UIImage.placeholder())
//        cell.imageMain.af_setImage(withURL:URL(string: character.thumbnail?.fullPath() ?? "")!, placeholderImage: UIImage.placeholder())
        return cell
    }
}

extension MainViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //requestCharacters(name: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //requestCharacters()
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}
