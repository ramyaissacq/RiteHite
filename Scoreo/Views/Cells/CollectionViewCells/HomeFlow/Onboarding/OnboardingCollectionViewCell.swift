//
//  OnboardingCollectionViewCell.swift
//  Core Score
//
//  Created by Remya on 9/30/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgCurrent: UIImageView!
    
    
    var callSkip:(()->Void)?
    var callNext:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        btnNext.setTitle("Next".localized, for: .normal)
        btnSkip.setTitle("Skip".localized, for: .normal)
        
    }
    
    override func layoutSubviews() {
        let gradient = btnNext.getGradientLayer(bounds: btnNext.bounds)
        btnNext.backgroundColor = btnNext.gradientColor(bounds: btnNext.bounds, gradientLayer: gradient)
    }
    
    func configureCell(title:String,description:String,image:UIImage,index:Int){
        lblTitle.text = title
        lblDescription.text = description
        pageControl.currentPage = index
        imgCurrent.image = image
        
    }
    
    @IBAction func actionSkip(){
        Utility.gotoHome()
        Utility.callURlDetailsAPI()
       // callSkip?()
    }
    
    @IBAction func actionCallNext(){
        callNext?()
    }

}
