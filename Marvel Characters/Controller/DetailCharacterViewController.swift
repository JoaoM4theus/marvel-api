//
//  DetailCharacterViewController.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 19/08/21.
//

import UIKit

class DetailCharacterViewController: UIViewController {
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var descriptionCharacter: UILabel!
    
    var image: String?
    var _extension: String?
    var name: String?
    var descricao: String?
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        nameCharacter.text = name
        descriptionCharacter.text = descricao
    }
    
    func setup() {
        setupImage()
        nameCharacter.text = name
        descriptionCharacter.text = descricao
    }
    
    func setupImage() {
        guard let imageUrl = image else { return }
        if _extension == "jpg" {
            imageCharacter.image = downloadImage(from: URL(string: imageUrl)!, view: imageCharacter)
        } else {
            imageCharacter.image = UIImage.gifImageWithURL(imageUrl)
        }
    }
}
