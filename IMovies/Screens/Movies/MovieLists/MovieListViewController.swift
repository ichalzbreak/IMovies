//
//  MovieListViewController.swift
//  IMovies
//
//  Created by Amrizal on 23/07/21.
//

import UIKit
import SVProgressHUD

class MovieListViewController : UIViewController, StoryboardScene {
    
    @IBOutlet weak var collectionViewMain: UICollectionView!
    
    var refreshControl:UIRefreshControl!
    
    var viewModel: MovieListViewModel!
    var genre:GenreModel!
    
    static func instantiate(_ genre:GenreModel) -> Self {
        let vc = MovieListViewController.instantiate()
        vc.genre = genre
        
        return vc as! Self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindEvents()
        
    }
    
}

extension MovieListViewController {
    
    func setupTableView() {
        collectionViewMain.delegate = self
        collectionViewMain.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionViewMain.refreshControl = refreshControl
        
        title = genre.title
    }
    
    @objc func handleRefreshControl() {
        viewModel.fetchMovies(genre)
    }
    
    private func bindEvents() {
        viewModel.isLoading
            .signal
            .take(during: reactive.lifetime)
            .observeValues({ (loading) in
                if loading {
                    SVProgressHUD.show()
                }else {
                    self.refreshControl.endRefreshing()
                    SVProgressHUD.dismiss()
                }
            })
        
        viewModel.error
            .signal
            .take(during: reactive.lifetime)
            .observeValues({ (error) in
                SVProgressHUD.showError(withStatus: error?.localizedDescription ?? "error")
            })
        
        viewModel.viewModels
            .signal
            .take(during: reactive.lifetime)
            .observe({ [weak self] (viewModels) in
                self?.collectionViewMain.reloadData()
            })
        
        viewModel.fetchMovies(genre)
    }
}


extension MovieListViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.viewModel.viewModels.value[indexPath.row]

        let vc = MovieDetailViewController.instantiate(item.item)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.viewModels.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = self.viewModel.viewModels.value[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath) as! MovieViewCell
        viewModel.setupView(cell)
        return cell
    }
    
    
}
