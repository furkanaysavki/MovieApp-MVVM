//
//  HomeCollectionViewCell.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 20.0
}
    func viewCell(model : Search ) {
        posterImage.kf.setImage(with: URL(string : model.poster))
        titleLabel.text = model.title
        
}
}
