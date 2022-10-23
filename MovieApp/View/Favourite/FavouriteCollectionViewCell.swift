//
//  FavouriteCollectionViewCell.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 18.10.2022.
//

import UIKit
import Kingfisher

class FavouriteCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    self.layer.borderWidth = 3
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.cornerRadius = 12
    self.clipsToBounds = true
    }
    
    func saveFavoriteMovie(model: Movie) {
        titleLabel.text = model.title
        
        posterImage.kf.setImage(with: URL(string: model.image ?? ""))
        
    }
}
