//
//  ViewController.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/05.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    var movieListViewViewModel: MovieListViewViewModel!
    let disposeBag = DisposeBag()
    
    var numberOfItem = 0
    
    var category: String = ""
    
    @IBOutlet weak var tableView:UITableView!
    
    let categories = ["",Constants.ACTION, Constants.ADVENTURE, Constants.ANIMATION, Constants.BIOGRAPHY, Constants.CRIME, Constants.DRAMA, Constants.FAMILY, Constants.HISTORY, Constants.MYSTERY, Constants.ROMANCE, Constants.SCI_FI, Constants.THRILLER]
    
    var viewController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListViewViewModel = MovieListViewViewModel(moviesApiClient: MoviesAPIClient.shared)
        
        print("these are movies: \(movieListViewViewModel)")
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

}

extension ViewController : UITableViewDelegate { }

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        category = categories[section]
        return category
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as? TitleTableViewCell else { return UITableViewCell() }
            
            cell.tileLable.text = "Wookies Movies"
            return cell
        } else {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CategoryRow else { return UITableViewCell() }
            
            cell.category = categories[indexPath.section]
            cell.viewController = self
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    /*
    func createNumberofItems(category: String) -> Int {
        movieListViewViewModel = MovieListViewViewModel(moviesApiClient: MoviesAPIClient.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[unowned self] (_) in
            
            var i = 0
            var ii = 0
            var count = 0
            
            if let viewModel = movieListViewViewModel.viewModelForMovie(at: i) {
                
                
                for i in 0..<movieListViewViewModel.numberOfMovies {
                    let viewModel = movieListViewViewModel.viewModelForMovie(at: i)
                    for ii in 0..<viewModel!.genres.count {
                        print(viewModel!.genres.count)
                        print(viewModel!.genres[ii])
                        
                        if (viewModel!.genres[ii] == category) {
                            count += 1
                        }
                        //i += 1
                        
                    }
                    
                    print("i is \(i)")
                    print(".....")
                }
                
            }
            numberOfItem = count
            print(count)
            
            
        }).disposed(by: disposeBag)
        return numberOfItem
    } */
    
}
