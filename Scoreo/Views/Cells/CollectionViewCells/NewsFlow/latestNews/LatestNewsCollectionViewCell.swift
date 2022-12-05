//
//  LatestNewsCollectionViewCell.swift
//  Scoreo
//
//  Created by Remya on 10/26/22.
//

import UIKit

class LatestNewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var imgGame: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    override func layoutSubviews() {
        imgGame.roundCorners(corners: [.topLeft,.topRight], radius: 8)
       
    }
    
    func configureCell(obj:NewsList?){
        lblTitle.text = obj?.title
        imgGame.setImage(with: obj?.path, placeholder: Utility.getPlaceHolder())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Utility.dateFormat.ddMMyyyyWithTimeZone.rawValue
        lblTime.text = Utility.formatDate(date: dateFormatter.date(from: obj?.createTime ?? ""), with: .ddMMMyyyy)
        
    }


}
