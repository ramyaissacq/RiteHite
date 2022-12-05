//
//  LiveMatchCollectionViewCell.swift
//  Scoreo
//
//  Created by Remya on 11/5/22.
//

import UIKit

class LiveMatchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblHomeName: UILabel!
    @IBOutlet weak var lblAwayName: UILabel!
    @IBOutlet weak var imgHomeLogo: UIImageView!
    @IBOutlet weak var imgAwayLogo: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var fixedLive: UILabel!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var rightImage: UIImageView!
    
    @IBOutlet weak var leftImage: UIImageView!
    
    var callForword:(()->Void)?
    var callBackword:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fixedLive.text = "LIVE".localized
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(goBackward))
        leftImage.addGestureRecognizer(tapLeft)
        
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(goForward))
        rightImage.addGestureRecognizer(tapRight)
    }
    
    override func layoutSubviews() {
        backView.roundCorners(corners: [.topLeft,.bottomRight], radius: 15)
    }
    
    @objc func goForward(){
        callForword?()
    }
    
    @objc func goBackward(){
        callBackword?()
        
    }
    
    func configureCell(obj:MatchList?){
        if KickOffViewController.urlDetails?.mapping?.count ?? 0 == 0{
            lblName.text = ""
        }
        else{
        lblName.text = obj?.leagueNameShort
            let gradient1 = lblName.getGradientLayer(bounds: lblName.bounds)
            lblName.textColor = lblName.gradientColor(bounds: lblName.bounds, gradientLayer: gradient1)
        }
        
        lblHomeName.text = obj?.homeName
        lblAwayName.text = obj?.awayName
        let mins = ScoresTableViewCell.timeInMins(startDate: obj?.startTime ?? "")
        lblTime.text = "\(mins)'"

        if obj?.state == 0 || obj?.state == -1{
            let matchDate = Utility.getSystemTimeZoneTime(dateString: obj?.matchTime ?? "")
            lblTime.text = Utility.formatDate(date: matchDate, with: .hhmm2)
           
        }
       
        imgAwayLogo.setImage(with: obj?.awayLogo, placeholder: Utility.getPlaceHolder())
        imgHomeLogo.setImage(with: obj?.homeLogo, placeholder: Utility.getPlaceHolder())
    }
    
    

}
