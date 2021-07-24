//
//  GenreItemViewModel.swift
//  IMovies
//
//  Created by Amrizal on 23/07/21.
//

import UIKit
import RandomColorSwift

class GenreItemViewModel {
    
    var item: GenreModel
    
    init(_ item: GenreModel) {
        self.item = item
    }
    
    func setupView(_ cell: GenreViewCell) {
        cell.labelTitle.text = item.title
        cell.labelTitle.textColor = .white
        cell.viewWrapper.backgroundColor = randomColor(hue: .monochrome, luminosity: .dark )
    }
}
