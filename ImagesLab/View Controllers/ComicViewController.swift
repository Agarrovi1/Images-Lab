//
//  ViewController.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var comicStepper: UIStepper!
    @IBOutlet weak var comicTextField: UITextField!
    @IBOutlet weak var comicImageView: UIImageView!
    
    var currentComic = XkcdComic() {
        didSet {
            loadPicture()
        }
    }
    var recentComic = XkcdComic() {
        didSet {
            comicStepper.maximumValue = Double(recentComic.num)
            comicStepper.minimumValue = 1
            comicStepper.stepValue = 1
        }
    }
    
    func loadCurrentComic() {
        let recentUrl = "https://xkcd.com/info.0.json"
        XkcdComic.getComic(from: recentUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let comic):
                DispatchQueue.main.async {
                    self.currentComic = comic
                    self.recentComic = comic
                }
            }
        }
    }
    func loadPicture() {
        ImageHelper.shared.fetchImage(urlString: currentComic.img) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let pic):
                DispatchQueue.main.async {
                    self.comicImageView.image = pic
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurrentComic()
        // Do any additional setup after loading the view.
    }


}

