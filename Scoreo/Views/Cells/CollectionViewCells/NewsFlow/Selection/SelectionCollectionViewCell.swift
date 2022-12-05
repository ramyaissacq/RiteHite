//
//  SelectionCollectionViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/1/22.
//

import UIKit

class SelectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stack: UIStackView!
    
    
    var callSelection:(()->Void)?
    var deSelectionColor = UIColor.clear
    var titleColor1 = UIColor.white
    var titleColor2 = Colors.textColor()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCall))
//        stack.addGestureRecognizer(tap)
        handleSelection()
    }
    
    override var isSelected: Bool{
        didSet{
          handleSelection()
        }
        
    }
    
    @objc func tapCall(){
         callSelection?()
    }
    
    func handleSelection(){
        if isSelected{
            let gradient = backView.getGradientLayer(bounds: backView.bounds)
            backView.backgroundColor = backView.gradientColor(bounds: backView.bounds, gradientLayer: gradient)
            lblTitle.textColor = titleColor1
        }
        else{
            self.backView.backgroundColor = deSelectionColor
            lblTitle.textColor = titleColor2
        }
    }

}
