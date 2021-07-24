//
//  SwinjectStoryboardExt.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        
        defaultContainer.register(MainService.self) { _ in MainService()}
        
        defaultContainer.register(GenreViewModel.self) { r in GenreViewModel(service: r.resolve(MainService.self)!)}
        defaultContainer.storyboardInitCompleted(GenreViewController.self) { r, c in
            c.viewModel = r.resolve(GenreViewModel.self)
        }
        
        defaultContainer.register(MovieListViewModel.self) { r in MovieListViewModel(service: r.resolve(MainService.self)!)}
        defaultContainer.storyboardInitCompleted(MovieListViewController.self) { r, c in
            c.viewModel = r.resolve(MovieListViewModel.self)
        }
        
        defaultContainer.register(MovieDetailViewModel.self) { r in MovieDetailViewModel(service: r.resolve(MainService.self)!)}
        defaultContainer.storyboardInitCompleted(MovieDetailViewController.self) { r, c in
            c.viewModel = r.resolve(MovieDetailViewModel.self)
        }
    }
}
