//
//  LiveMatchesTableViewCell.swift
//  Scoreo
//
//  Created by Remya on 11/7/22.
//

import UIKit

class LiveMatchesTableViewCell: UITableViewCell {
 
    @IBOutlet weak var collectionViewMatches:UICollectionView!
    
    //MARK: - Variables
    var matches:[MatchList]?{
        didSet{
            collectionViewMatches.reloadData()
        }
    }
    
    var callSelection:((Int)->Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewMatches.registerCell(identifier: "LiveMatchCollectionViewCell")
        collectionViewMatches.registerCell(identifier: "EmptyLiveCollectionViewCell")
        collectionViewMatches.delegate = self
        collectionViewMatches.dataSource = self
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension LiveMatchesTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if matches?.count ?? 0 == 0{
            return 1
        }
        else{
            return matches?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if matches?.count ?? 0  == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyLiveCollectionViewCell", for: indexPath) as! EmptyLiveCollectionViewCell
            return cell
        }
        else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveMatchCollectionViewCell", for: indexPath) as! LiveMatchCollectionViewCell
        cell.configureCell(obj: matches?[indexPath.row])
            cell.callForword = {
                if indexPath.row + 1 == (self.matches?.count ?? 0){
                    return
                }
                collectionView.scrollToItem(at: IndexPath(row: indexPath.row+1, section: 0), at: .right, animated: true)
            }
            
            cell.callBackword = {
                if indexPath.row == 0{
                    return
                }
                collectionView.scrollToItem(at: IndexPath(row: indexPath.row-1, section: 0), at: .right, animated: true)
                
            }
        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if matches?.count ?? 0 > 0 {
        callSelection?(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        return CGSize(width: width, height: 221)
    }
    
    
}
