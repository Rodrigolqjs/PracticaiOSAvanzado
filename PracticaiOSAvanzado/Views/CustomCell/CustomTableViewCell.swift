//
//  CustomTableViewCell.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import UIKit



class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    func set(customCellModel: CustomCellModel) {
        self.nameLabel.text = customCellModel.name
        self.descriptionLabel.text = customCellModel.description
        self.imageView?.setImage(url:  customCellModel.photo.absoluteString)
    }
}
