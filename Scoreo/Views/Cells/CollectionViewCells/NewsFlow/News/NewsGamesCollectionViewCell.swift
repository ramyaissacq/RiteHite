//
//  NewsGamesCollectionViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/1/22.
//

import UIKit

class NewsGamesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var imgGame: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    override func layoutSubviews() {
        greenView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 8)
    }
    
    func configureCell(obj:NewsList?){
        lblTitle.text = obj?.title
        imgGame.setImage(with: obj?.path, placeholder: Utility.getPlaceHolder())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Utility.dateFormat.ddMMyyyyWithTimeZone.rawValue
        lblTime.text = Utility.formatDate(date: dateFormatter.date(from: obj?.createTime ?? ""), with: .ddMMMyyyy)
    }

}
