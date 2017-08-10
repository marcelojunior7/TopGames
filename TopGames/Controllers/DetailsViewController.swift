//
//  DetailsViewController.swift
//  TopGames
//
//  Created by Marcelo on 31/07/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {
    
    var game:Game?
    @IBOutlet weak var imageTopBackground: UIImageView!
    @IBOutlet weak var imageTopCenter: UIImageView!
    @IBOutlet weak var labelChannels: UILabel!
    @IBOutlet weak var labelViewers: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    class func instance(game:Game) -> DetailsViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        controller.game = game
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.navigationItem.title = "Details"
        labelViewers.stroke(text: "\(game?.viewers ?? 0) views")
        labelChannels.stroke(text: "\(game?.channels ?? 0) channels")
        labelTitle.stroke(text: game?.name ?? "")
        if let url = URL(string: game?.thumbnail ?? "") {
            imageTopBackground.af_setImage(withURL:url, placeholderImage: UIImage.placeholder())
            imageTopCenter.af_setImage(withURL:url, placeholderImage: UIImage.placeholder())
        } else {
            imageTopBackground.image = UIImage.placeholder()
            imageTopCenter.image = UIImage.placeholder()
        }
    }
}
