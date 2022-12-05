//
//  SoonTableViewCell.swift
//  Scoreo
//
//  Created by Remya on 11/7/22.
//

import UIKit

class SoonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblHomeName: UILabel!
    @IBOutlet weak var lblAwayName: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgHomeLogo: UIImageView!
    @IBOutlet weak var imgAwayLogo: UIImageView!
    @IBOutlet weak var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
     // backView1.roundCorners(corners: [.topRight], radius: 25)
       // backView2.roundCorners(corners: [.bottomRight], radius: 25)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(obj:MatchList?){
        
//        if KickOffViewController.urlDetails?.mapping?.count ?? 0 == 0{
//            lblName.text = ""
//        }
//        else{
//        lblName.text = obj?.leagueNameShort
//        }
        lblName.text = obj?.leagueNameShort
        lblHomeName.text = obj?.homeName
        lblAwayName.text = obj?.awayName
        imgAwayLogo.setImage(with: obj?.awayLogo, placeholder: Utility.getPlaceHolder())
        imgHomeLogo.setImage(with: obj?.homeLogo, placeholder: Utility.getPlaceHolder())
        
            let matchDate = Utility.getSystemTimeZoneTime(dateString: obj?.matchTime ?? "")
        lblScore.text = "\(obj?.homeScore ?? 0) : \(obj?.awayScore ?? 0)"
        lblDate.text = Utility.formatDate(date: matchDate, with: .hhmm2)
        
        let gradient1 = lblName.getGradientLayer(bounds: lblName.bounds)
        lblName.backgroundColor = lblName.gradientColor(bounds: lblName.bounds, gradientLayer: gradient1)
        
        let gradient2 = lblDate.getGradientLayer(bounds: lblDate.bounds)
        lblDate.backgroundColor = lblDate.gradientColor(bounds: lblDate.bounds, gradientLayer: gradient2)
        
        
    }
    
}
