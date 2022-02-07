//
//  SingleLabelCell.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 06/02/22.
//

import UIKit

class SingleLabelCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWith(data: String) {
        titleLabel.text = data
    }
    
}
