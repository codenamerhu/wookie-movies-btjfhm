//
//  MovieTableViewCell.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/12.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: MovieViewViewModel) {
            titleLabel.text = viewModel.title
        
        posterImage.load(url: URL(string: viewModel.poster)!)
        }
    
}
