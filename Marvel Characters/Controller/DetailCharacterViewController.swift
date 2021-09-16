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
    
    var viewModel: DetailCharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupImage()
        nameCharacter.text = viewModel?.configName()
        descriptionCharacter.text = viewModel?.configDescription()
    }
    
    func setupImage() {
        guard let imageUrl = viewModel?.configImage() else { return }
        if viewModel?.configExtension() == "jpg" {
            imageCharacter.image = downloadImage(from: URL(string: imageUrl)!, view: imageCharacter)
        } else {
            imageCharacter.image = UIImage.gifImageWithURL(imageUrl)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, view: UIImageView) -> UIImage {
//        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                view.image = UIImage(data: data)
            }
        }
        return view.image ?? UIImage()
    }
}
