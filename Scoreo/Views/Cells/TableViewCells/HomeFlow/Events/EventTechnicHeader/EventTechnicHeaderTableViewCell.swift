//
//  EventTechnicHeaderTableViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/13/22.
//

import UIKit

class EventTechnicHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var fixedTechniq: UILabel!
    
    @IBOutlet weak var lblAway: UILabel!
    @IBOutlet weak var lblHome: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fixedTechniq.text = "Technic".localized
        let gradient = fixedTechniq.getGradientLayer(bounds: fixedTechniq.bounds)
        fixedTechniq.textColor = fixedTechniq.gradientColor(bounds: fixedTechniq.bounds, gradientLayer: gradient)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(home:String?,away:String?){
        lblHome.text = home
        lblAway.text = away
    }
    
}
