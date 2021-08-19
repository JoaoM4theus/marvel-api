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
    var name: String?
    var descricao: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadToImage = image {
            imageCharacter.image = UIImage(named: loadToImage)
        }
        nameCharacter.text = name
        descriptionCharacter.text = descricao
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
