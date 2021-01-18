//
//  MovieDetailsViewController.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/11.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    public static let identifier = "MovieDetailsViewController"
    var movieModelView: MovieViewViewModel?
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("this \(movieModelView)")
        insertDataToViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    func insertDataToViews() {
        
        //backdropImageView.load(url: movieModelView.b)
        backdropImageView.load(url: URL(string: movieModelView!.backdrop)!)
        posterImageview.load(url: URL(string: movieModelView!.poster)!)
        titleLabel.text = movieModelView!.title
        overviewLabel.text = movieModelView!.overview
        var castNames  = ""
        for cast in movieModelView!.cast {
            
            castNames.append("\(cast), ")
        }
        
        castLabel.text = "Cast: \(castNames)"
        lengthLabel.text = movieModelView!.length
        
        
        var directors = ""
        for director in movieModelView!.director {
            directors.append("\(director), ")
        }
        directorLabel.text = directors
        
        yearLabel.text = movieModelView!.yeer
        
        ratingLabel.text = "\(movieModelView!.rating)"
        
        var rating: String {
            let rating = Int(movieModelView!.rating)
                let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
                    return acc + "⭐️"
                }
                return ratingText
            }
        starsLabel.text = rating

        
        print(movieModelView!.director)
    }
    
    @IBAction func back(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    

}


