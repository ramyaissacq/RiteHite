//
//  KickOffSelectionCollectionViewCell.swift
//  Scoreo
//
//  Created by Remya on 11/5/22.
//

import UIKit

class KickOffSelectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var underLine:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        handleSelection()
    }
    
    override var isSelected: Bool{
        didSet{
            handleSelection()
        }
    }
    
    func handleSelection(){
        if isSelected{
            
            lblTitle.textColor = .black
            let gradient2 = underLine.getGradientLayer(bounds: underLine.bounds)
            underLine.backgroundColor = underLine.gradientColor(bounds: underLine.bounds, gradientLayer: gradient2)
        }
        else{
            lblTitle.textColor = .black
            underLine.backgroundColor = .clear
        }
        
    }

}
