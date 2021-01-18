//
//  CategoryRow.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/08.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol NavigateProtocol: UIViewController {
    func navigateTo(viewMovel: MovieViewViewModel)
}

class CategoryRow: UITableViewCell {
    
    var movieListViewViewModel: MovieListViewViewModel!
    let disposeBag = DisposeBag()
    var category: String = ""
    
    var moviesDetails: MovieDetailsViewController = MovieDetailsViewController()
    
    var viewController: ViewController!
    
    var vModel: MovieListViewViewModel? {
        didSet {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func prepareForReuse() {
        
        movieListViewViewModel = MovieListViewViewModel(moviesApiClient: MoviesAPIClient.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[unowned self] (_) in
            
            
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    var numberOfItem: Int = 0
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        movieListViewViewModel = MovieListViewViewModel(moviesApiClient: MoviesAPIClient.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[unowned self] (_) in
            
            
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        
        //print(vModel!.movies)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //func insertMoviesIntoArray()
}

extension CategoryRow : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return movieListViewViewModel.varNumberOfMoviesInGenre(genreIs: category)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
        
        movieViewController.movieModelView = movieListViewViewModel.viewModelForMovieByGenre(at: indexPath.row, for: category)
        viewController.navigationController?.pushViewController(movieViewController, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as? VideoCell else { return UICollectionViewCell() }
        print(category)
        if let viewModel = movieListViewViewModel.viewModelForMovieByGenre(at: indexPath.row, for: category) {
            for genre in viewModel.genres {
                if (genre == category) {
                    //print("\(genre) - \(category)")
                    //print(viewModel.title)
                    cell.configureCell(viewModel: viewModel)
                }
                //print("........")
                
                
            }
            
        }
            
    
        
        return cell
    }
    
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

