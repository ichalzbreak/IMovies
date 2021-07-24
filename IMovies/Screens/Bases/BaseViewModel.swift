//
//  BaseViewModel.swift
//  IMovies
//
//  Created by Amrizal on 23/07/21.
//

import ReactiveSwift

class BaseViewModel {
    
    var isLoading : MutableProperty<Bool> = MutableProperty(false)

    var error = MutableProperty<Error?>(nil)
}
