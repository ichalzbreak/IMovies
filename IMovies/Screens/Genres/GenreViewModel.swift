//
//  GenreViewModel.swift
//  IMovies
//
//  Created by Amrizal on 23/07/21.
//

import ReactiveSwift

class GenreViewModel : BaseViewModel {
    
    var viewModels: MutableProperty<[GenreItemViewModel]> = MutableProperty([GenreItemViewModel]())
    
    private var service: MainService
    
    init(service: MainService) {
        self.service = service
    }
    
    func fetchGenres() {
        self.isLoading.value = true
        
        self.service
            .fetchGenres()
            .start(Signal<[GenreModel], Error>.Observer (value: { [weak self] values in
                self?.viewModels.value = values.compactMap{return GenreItemViewModel($0)}
                self?.isLoading.value = false
                
            }, failed: { [weak self] error in
                self?.isLoading.value = false
                self?.error.value = error
            }))
    }
}
