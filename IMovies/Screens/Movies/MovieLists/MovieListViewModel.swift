//
//  MovieListViewModel.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import ReactiveSwift

class MovieListViewModel : BaseViewModel {
    
    var viewModels: MutableProperty<[MovieItemViewModel]> = MutableProperty([MovieItemViewModel]())
    
    private var service: MainService
    
    init(service: MainService) {
        self.service = service
    }
    
    func fetchMovies(_ genre:GenreModel) {
        self.isLoading.value = true
        
        self.service
            .fetchMovies(genre)
            .start(Signal<[MovieModel], Error>.Observer (value: { [weak self] values in
                self?.viewModels.value = values.compactMap{return MovieItemViewModel($0)}
                self?.isLoading.value = false
                
            }, failed: { [weak self] error in
                
                self?.isLoading.value = false
                self?.error.value = error
            }))
    }
}
