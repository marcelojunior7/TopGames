//
//  MainViewController.swift
//  TopGames
//
//  Created by Marcelo on 31/07/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import KRPullLoader

class MainViewController : UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var games = [Game]()
    var filteredGames = [Game]()
    var twitchAPI = TwitchAPI()
  
    class func instance() -> MainViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showSpinner()
        requestTop()
    }
    
    func setupUI() {
        navigationItem.title = "Top 50 on Twitch"
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        collectionView.addPullLoadableView(refreshView, type: .refresh)
    }

    //MARK: Service
    
    func requestTop(completionHandler:(()->Void)? = nil) {
        twitchAPI.top(success: { (games) in
            self.games = games
            self.filter()
            self.hideSpinner()
            completionHandler?()
        }) { (error) in
            self.hideSpinner()
            if let error = error {
                self.showAlert(text: error.localizedDescription)
            } else {
                self.showAlert(text: "Oops, something went wrong")
            }
            completionHandler?()
        }
    }
    
    //MARK: helpers
    
    func showAlert(text:String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showSpinner() {
        activityIndicator.startAnimating()
        collectionView.isHidden = true
    }
    
    func hideSpinner() {
        activityIndicator.stopAnimating()
        collectionView.isHidden = false
    }
}

extension MainViewController : KRPullLoadViewDelegate {
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        switch state {
        case let .loading(completionHandler):
            requestTop(completionHandler: completionHandler)
            break
        default:
            break
        }
    }
}


extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        let game = filteredGames[indexPath.row]
        cell.labelTitle.text = game.name
        if let url = URL(string: game.thumbnail) {
            cell.imageBackground.af_setImage(withURL:url, placeholderImage: UIImage.placeholder())
            cell.imageMain.af_setImage(withURL:url, placeholderImage: UIImage.placeholder())
        } else {
            cell.imageBackground.image = UIImage.placeholder()
            cell.imageMain.image = UIImage.placeholder()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailsViewController.instance(game: filteredGames[indexPath.item]), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.isSmallScreen {
            return CGSize(width: 140, height: 140)
        } else {
            return CGSize(width: 170, height: 170)
        }
    }
}

extension MainViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filter()
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        filter()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter()
    }
    
    func filter() {
        guard let searchText = searchBar.text else { return }
        filteredGames = searchText.isEmpty ? games : games.filter({(game: Game) -> Bool in
            return game.name.range(of: searchText, options: .caseInsensitive) != nil
        })
        collectionView.reloadData()
    }
}
