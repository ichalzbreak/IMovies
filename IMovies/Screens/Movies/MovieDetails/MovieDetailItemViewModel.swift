//
//  MovieDetailItemViewModel.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import Foundation

class MovieDetailItemViewModel {
    var item: MovieModel
    
    init() {
        item = MovieModel()
    }
    
    init(_ item: MovieModel) {
        self.item = item
    }
    
    func setupView(_ vc: MovieDetailViewController) {
        let backdropUrl = URL(string: "\(UrlConstant.imageUrl)/w780/\(item.backdrop_path ?? "")")
        vc.imagePoster.sd_setImage(with: backdropUrl, completed: nil)
        let posterUrl = URL(string: "\(UrlConstant.imageUrl)/w185/\(item.poster_path ?? "")")
        vc.imageProfile.sd_setImage(with: posterUrl, completed: nil)
        vc.labelTitle.text = item.title
        vc.labelStoryline.text = item.overview
        vc.labelReleaseDate.text = item.release_date
        vc.ratingView.rating = Double(item.vote_average ?? 0) / 2
        vc.labelTotalVote.text = "\(item.vote_average ?? 0.0)"
    }
}

class MovieDetailItemCreditViewModel {
    
    var item: CreditListModel?
    
    init() {}
    
    init(_ item: CreditListModel) {
        self.item = item
    }
    
    func setupView(_ vc: MovieDetailViewController) {
        if let director = item?.crew.first(where: {$0.job == "Director"}) {
            vc.labelDirector.text = director.name
        }
        
        if let writers = item?.crew.filter({ $0.department == "Writing" }).compactMap({return $0.name }) {
            vc.labelWriters.text = writers.joined(separator: ", ")
            
        }
    }
    
}

class MovieDetailItemCreditCellViewModel {
    
    var item: CreditModel?
    
    init() {}
    
    init(_ item: CreditModel) {
        self.item = item
    }
    
    func setupCell(_ cell: MovieDetailCreditViewCell) {
        let posterUrl = URL(string: "\(UrlConstant.imageUrl)/w92/\(item?.profile_path ?? "")")
        cell.imageThumb.sd_setImage(with: posterUrl, completed: nil)
        cell.labelName.text = item?.name
        cell.labelCharacter.text = item?.character

    }
    
}
