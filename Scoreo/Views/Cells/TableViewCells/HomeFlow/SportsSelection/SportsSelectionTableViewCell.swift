//
//  SportsSelectionTableViewCell.swift
//  Scoreo
//
//  Created by Remya on 10/28/22.
//

import UIKit

class SportsSelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var imgSport:UIImageView!
    @IBOutlet weak var lblSport:UILabel!

    @IBOutlet weak var imgSelection: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            imgSelection.image = UIImage(named: "RadioButton")
        }
        else{
            imgSelection.image = UIImage(named: "greenRound")
        }

        // Configure the view for the selected state
    }
    
    func configureCell(obj:Sports){
        imgSport.image = obj.icon
        lblSport.text = obj.name
    }
    
}
