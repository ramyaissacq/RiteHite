//
//  EmptySoonTableViewCell.swift
//  Scoreo
//
//  Created by Remya on 11/8/22.
//

import UIKit

class EmptySoonTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var backView:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.text = "There is no match happening soon".localized
    }
    
    override func layoutSubviews() {
       // backView.roundCorners(corners: [.topLeft,.bottomRight], radius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
