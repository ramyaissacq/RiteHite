//
//  EmptyLiveCollectionViewCell.swift
//  Scoreo
//
//  Created by Remya on 11/8/22.
//

import UIKit

class EmptyLiveCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var backView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.text = "There is no match \n happening now".localized
    }
    
    override func layoutSubviews() {
      //  backView.roundCorners(corners: [.topLeft,.bottomRight], radius: 20)
    }

}
