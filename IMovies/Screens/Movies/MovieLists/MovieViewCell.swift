//
//  MovieViewCell.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import UIKit

class MovieViewCell : UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageThumb: UIImageView!
    
    static let identifier = "MovieViewCell"
}
