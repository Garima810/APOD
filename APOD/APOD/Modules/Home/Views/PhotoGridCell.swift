//
//  PhotoGridCell.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import UIKit


class PhotoGridCell: UITableViewCell {

    @IBOutlet weak var gridImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithImage(image: UIImage) {    
        gridImageView.image = image
    }
    
}
