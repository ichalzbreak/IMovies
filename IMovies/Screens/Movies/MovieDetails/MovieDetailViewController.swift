//
//  MovieDetailViewController.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import UIKit
import Cosmos
import SDWebImage
import SVProgressHUD

class MovieDetailViewController : UIViewController, StoryboardScene {
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var labelTotalVote: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelDirector: UILabel!
    @IBOutlet weak var labelWriters: UILabel!
    @IBOutlet weak var labelStoryline: UILabel!
    @IBOutlet weak var collectionCredit: UICollectionView!
    
    var viewModel: MovieDetailViewModel!
    var movie:MovieModel!
    
    static func instantiate(_ movie:MovieModel) -> Self {
        let vc = MovieDetailViewController.instantiate()
        vc.movie = movie
        return vc as! Self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindEvents()
        
    }
    
    @IBAction func onBtnPlayClicked(_ sender: Any) {
        
    }
    
}

extension MovieDetailViewController {
    
    func setupView() {
//        collectionCredit.delegate = self
        collectionCredit.dataSource = self
        
    }
    
    private func bindEvents() {
        viewModel.isLoading
            .signal
            .take(during: reactive.lifetime)
            .observeValues({ (loading) in
                
            })
        
        viewModel.error
            .signal
            .take(during: reactive.lifetime)
            .observeValues({ (error) in
                SVProgressHUD.showError(withStatus: error?.localizedDescription ?? "error")
            })
        
        viewModel.detailViewModel
            .signal
            .take(during: reactive.lifetime)
            .observe({ [weak self] (detail) in
                guard let vc = self else { return }
                self?.viewModel.detailViewModel.value.setupView(vc)
            })
        
        viewModel.castViewModel
            .signal
            .take(during: reactive.lifetime)
            .observe({ [weak self] (detail) in
                guard let vc = self else { return }
                self?.viewModel.creditViewModel.value.setupView(vc)
                self?.collectionCredit.reloadData()
            })
        
        viewModel.fetchMovie(movie)
        viewModel.fetchCredit(movie)
    }
    
}

extension MovieDetailViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.castViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = self.viewModel.castViewModel.value[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCreditViewCell.identifier, for: indexPath) as! MovieDetailCreditViewCell
        viewModel.setupCell(cell)
        return cell
    }
    
    
}
