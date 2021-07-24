//
//  GenreViewController.swift
//  IMovies
//
//  Created by Amrizal on 22/07/21.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import SVProgressHUD

class GenreViewController: UIViewController, StoryboardScene {

    @IBOutlet weak var collectionViewGenre: UICollectionView!
    
    var viewModel: GenreViewModel!
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindEvents()
        
    }
}

extension GenreViewController {
    
    func setupTableView() {
        collectionViewGenre.delegate = self
        collectionViewGenre.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionViewGenre.refreshControl = refreshControl
    }
    
    @objc func handleRefreshControl() {
        viewModel.fetchGenres()
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
                self?.collectionViewGenre.reloadData()
            })
        
        viewModel.fetchGenres()
    }
}

extension GenreViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let genre = self.viewModel.viewModels.value[indexPath.row]
        
        let vc = MovieListViewController.instantiate(genre.item)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GenreViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView {
            
            sectionHeader.labelTitle.text = "Official Genres"
            
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.viewModels.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = self.viewModel.viewModels.value[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreViewCell.identifier, for: indexPath) as! GenreViewCell
        viewModel.setupView(cell)
        return cell
    }
    
    
}
