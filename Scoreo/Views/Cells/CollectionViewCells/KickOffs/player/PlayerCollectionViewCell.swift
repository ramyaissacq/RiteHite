//
//  PlayerCollectionViewCell.swift
//  Scoreo
//
//  Created by Remya on 11/9/22.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var imgPlayer:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(obj:LinupPlayer?){
        lblName.text = obj?.name
        if obj?.image == ""{
        imgPlayer.image = UIImage(named: "Player")
            imgPlayer.contentMode = .scaleAspectFit
        }
        else{
            imgPlayer.setImage(with: obj?.image, placeholder: UIImage(named: "Player"))
            imgPlayer.contentMode = .scaleToFill
        }
    }

}
