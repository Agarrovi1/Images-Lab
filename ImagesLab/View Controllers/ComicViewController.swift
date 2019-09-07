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
            comicStepper.value = Double(currentComic.num)
            comicTextField.placeholder = " \(currentComic.num): \(currentComic.safe_title)"
            if currentComic.num == recentComic.num {
                recentButton.isEnabled = false
            } else {
                recentButton.isEnabled = true
            }
        }
    }
    var recentComic = XkcdComic() {
        didSet {
            comicStepper.maximumValue = Double(recentComic.num)
            comicStepper.minimumValue = 1
            comicStepper.stepValue = 1
            comicStepper.value = Double(recentComic.num)
        }
    }
    
    @IBAction func recentButtonPressed(_ sender: UIButton) {
        currentComic = recentComic
        sender.isEnabled = false
    }
    
    @IBAction func stepperStepped(_ sender: UIStepper) {
        let newUrl = ComicUrlHolder().getComicUrlFromDouble(num:sender.value)
        updateComic(with: newUrl)
    }
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        let randomNum = Int.random(in: 1...recentComic.num)
        let newUrl = ComicUrlHolder().getSpecificComicUrl(num: randomNum)
        updateComic(with: newUrl)
    }
    
    
    func updateComic(with url: String) {
        XkcdComic.getComic(from: url) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let comic):
                DispatchQueue.main.async {
                    self.currentComic = comic
                    self.loadPicture()
                }
            }
        }
    }
    func loadCurrentComic() {
        let recentUrl = ComicUrlHolder().recentUrl
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
        comicTextField.delegate = self
        // Do any additional setup after loading the view.
    }


}

extension ComicViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = comicTextField.text
        if let text = text, let num = Int(text) {
            switch num {
            case 1...recentComic.num:
                let newUrl = ComicUrlHolder().getSpecificComicUrl(num: num)
                updateComic(with: newUrl)
                comicTextField.text = ""
                return true
            default:
                comicTextField.text = ""
                return true
            }
        }
        comicTextField.text = ""
        return true
    }
}
