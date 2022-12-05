//
//  LiveMatchView.swift
//  Scoreo
//
//  Created by Remya on 11/9/22.
//

import Foundation
import UIKit

class LiveMatchView:UIView{
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblHomeName: UILabel!
    @IBOutlet weak var lblAwayName: UILabel!
    @IBOutlet weak var imgHomeLogo: UIImageView!
    @IBOutlet weak var imgAwayLogo: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
    
       
       func commonInit() {
           Bundle.main.loadNibNamed("LiveMatchView", owner: self, options: nil)
           contentView.fixInView(self)
           
       }
    
    override func layoutSubviews() {
        //backView.roundCorners(corners: [.topLeft,.bottomRight], radius: 15)
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
        let matchDate = Utility.getSystemTimeZoneTime(dateString: obj?.matchTime ?? "")
        lblTime.text = Utility.formatDate(date: matchDate, with: .hhmm2)

        imgAwayLogo.setImage(with: obj?.awayLogo, placeholder: Utility.getPlaceHolder())
        imgHomeLogo.setImage(with: obj?.homeLogo, placeholder: Utility.getPlaceHolder())
        lblScore.text = "\(obj?.homeScore ?? 0) : \(obj?.awayScore ?? 0)"
        
        let gradient1 = lblName.getGradientLayer(bounds: lblName.bounds)
        lblName.backgroundColor = lblName.gradientColor(bounds: lblName.bounds, gradientLayer: gradient1)
        
        let gradient2 = lblTime.getGradientLayer(bounds: lblTime.bounds)
        lblTime.backgroundColor = lblTime.gradientColor(bounds: lblTime.bounds, gradientLayer: gradient2)
    }
    
}
