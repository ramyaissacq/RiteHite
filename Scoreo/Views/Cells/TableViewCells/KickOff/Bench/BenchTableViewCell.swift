//
//  BenchTableViewCell.swift
//  Scoreo
//
//  Created by Remya on 11/9/22.
//

import UIKit

class BenchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var smallBackView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgPlayer: UIImageView!
    
    @IBOutlet weak var lblPlayerName: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    
    @IBOutlet weak var lblPlayerNo: UILabel!
    @IBOutlet weak var lblPlayerValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
      //  backView.roundCorners(corners: [.topLeft,.bottomRight], radius: 10)
      //  smallBackView.roundCorners(corners: [.topLeft,.bottomRight], radius: 6)
    }
    
    
    func configureCell(obj:PreviewLineup?){
        if Utility.getCurrentLang() == "cn"{
            lblPlayerName.text = obj?.nameChs
        }
        else{
            lblPlayerName.text = obj?.nameEn
        }
        imgPlayer.image = UIImage(named: "Player")
        imgPlayer.contentMode = .scaleAspectFit
        rightView.isHidden = true
        
    }
    
    func configureCell(obj:Lineup?){
        
        if Utility.getCurrentLang() == "cn"{
            lblPlayerName.text = obj?.nameChs
        }
        else{
            lblPlayerName.text = obj?.nameEn
        }
        imgPlayer.setImage(with: obj?.playerPhoto, placeholder:  UIImage(named: "Player"))
        lblCountry.text = obj?.playerCountry
        lblPlayerNo.text = obj?.number
        lblPlayerValue.text = obj?.playerValue
        rightView.isHidden = false
        
    }
    
    
    
}
