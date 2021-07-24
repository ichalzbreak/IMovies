//
//  MovieItemViewModel.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import Foundation
import SDWebImage

class MovieItemViewModel {
    
    var item: MovieModel
    
    init(_ item: MovieModel) {
        self.item = item
    }
    
    func setupView(_ cell: MovieViewCell) {
        let imageUrl = URL(string: "\(UrlConstant.imageUrl)/w185/\(item.poster_path ?? "")")
        cell.imageThumb.sd_setImage(with:imageUrl , completed: nil)
    }
}
