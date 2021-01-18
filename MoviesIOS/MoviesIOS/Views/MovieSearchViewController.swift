//
//  MovieSearchViewController.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/12.
//

import UIKit
import RxCocoa
import RxSwift

class MovieSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var searchBarView: UISearchBar!
    
    var movieSearchViewViewModel: MovieSearchViewViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
                let searchBar = self.navigationItem.searchController!.searchBar
        //let searchBar = searchBarView
        
        movieSearchViewViewModel = MovieSearchViewViewModel(query: searchBar.rx.text.orEmpty.asDriver(), moviesApiClient: MoviesAPIClient.shared)
        
        movieSearchViewViewModel.movies.drive(onNext: {[unowned self] (_) in
                    self.tableView.reloadData()
                }).disposed(by: disposeBag)
        
        movieSearchViewViewModel.movies.drive(onNext: {[unowned self] (_) in
                    self.tableView.reloadData()
                }).disposed(by: disposeBag)
                
                movieSearchViewViewModel.isFetching.drive(activityIndicatorView.rx.isAnimating)
                    .disposed(by: disposeBag)
            
                movieSearchViewViewModel.info.drive(onNext: {[unowned self] (info) in
                    self.infoLabel.isHidden = !self.movieSearchViewViewModel.hasInfo
                    self.infoLabel.text = info
                }).disposed(by: disposeBag)
                
                
                
        searchBar.rx.searchButtonClicked
                    .asDriver(onErrorJustReturn: ())
                    .drive(onNext: { [unowned searchBar] in
                        searchBar.resignFirstResponder()
                    }).disposed(by: disposeBag)
                
        searchBar.rx.cancelButtonClicked
                    .asDriver(onErrorJustReturn: ())
                    .drive(onNext: { [unowned searchBar] in
                        searchBar.resignFirstResponder()
                    }).disposed(by: disposeBag)

        setupTableView()
    }
    
    private func setupNavigationBar() {
            navigationItem.searchController = UISearchController(searchResultsController: nil)
            self.definesPresentationContext = true
            navigationItem.searchController?.dimsBackgroundDuringPresentation = false
            navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
            
            navigationItem.searchController?.searchBar.sizeToFit()
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        private func setupTableView() {
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
            tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        }
    

}

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSearchViewViewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        if let viewModel = movieSearchViewViewModel.viewModelForMovie(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }
        return cell
    }
        
}
