//
//  TitleTableViewCell.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/15.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tileLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
