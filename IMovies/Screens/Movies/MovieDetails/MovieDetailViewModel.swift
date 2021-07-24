//
//  MovieDetailViewModel.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import ReactiveSwift

class MovieDetailViewModel : BaseViewModel {
    
    var detailViewModel: MutableProperty<MovieDetailItemViewModel> = MutableProperty(MovieDetailItemViewModel())
    var creditViewModel: MutableProperty<MovieDetailItemCreditViewModel> = MutableProperty(MovieDetailItemCreditViewModel())
    var castViewModel: MutableProperty<[MovieDetailItemCreditCellViewModel]> = MutableProperty([MovieDetailItemCreditCellViewModel]())
    
    private var service: MainService
    
    init(service: MainService) {
        self.service = service
    }
    
    func fetchMovie(_ movie:MovieModel) {

        detailViewModel.value = MovieDetailItemViewModel(movie)
        
    }
    
    func fetchCredit(_ movie:MovieModel) {
        guard let id = movie.id else {
            return
        }
        
        self.isLoading.value = true

        self.service
            .fetchCredit(id)
            .start(Signal<CreditListModel, Error>.Observer (value: { [weak self] value in
                self?.creditViewModel.value = MovieDetailItemCreditViewModel(value)
                
                if let castings = self?.creditViewModel.value.item?.cast.prefix(10).compactMap({return MovieDetailItemCreditCellViewModel($0) }) {
                    self?.castViewModel.value =  castings
                }
                
                self?.isLoading.value = false

            }, failed: { [weak self] error in

                self?.isLoading.value = false
                self?.error.value = error
            }))
    }
    
}


