//
//  VideoCell.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/08.
//

import Foundation
import UIKit

class VideoCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(viewModel: MovieViewViewModel) {
        
        imageView.load(url: URL(string: viewModel.poster)!)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
