//
//  LinupViewController.swift
//  Scoreo
//
//  Created by Remya on 11/9/22.
//

import UIKit


class LinupViewController: BaseViewController {
   
    @IBOutlet weak var collectionViewTop: UICollectionView!
    @IBOutlet weak var liveMatchView: LiveMatchView!
    
    @IBOutlet weak var webViewContainer: UIView!
    
    @IBOutlet weak var eventContainer: UIView!
    
    //MARK: - Variables
    var match:MatchList?
    var titlesArray = ["ANIMATION".localized,"EVENT".localized]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()

       
    }
    
    
    
    
    
    func initialSetup(){
        setupNavBar()
       
        liveMatchView.configureCell(obj: match)
        collectionViewTop.registerCell(identifier: "KickOffSelectionCollectionViewCell")
        collectionViewTop.reloadData()
        collectionViewTop.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
       
    }
    
    func setupNavBar(){
        self.navigationItem.titleView = getGradientHeaderLabel(title: "Details".localized)
        setBackButton()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WebViewViewController{
            if Utility.getCurrentLang() == "cn" {
                
            vc.urlString  = match?.animateURLCn ?? ""
            }
            else{
                vc.urlString  = match?.animateURLEn ?? ""
            }
            if match?.animateURLEn?.count ?? 0 > 0{
                print(match?.animateURLEn)
            }
        }
        
        if segue.destination is EventViewController{
            HomeCategoryViewController.matchID = match?.matchId
        }
    }
  
    
}


extension LinupViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return titlesArray.count
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionViewTop.dequeueReusableCell(withReuseIdentifier: "KickOffSelectionCollectionViewCell", for: indexPath) as! KickOffSelectionCollectionViewCell
            cell.lblTitle.text = titlesArray[indexPath.row]
            return cell
            
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        if indexPath.row == 0{
            webViewContainer.isHidden = false
            eventContainer.isHidden = true
        }
        else{
            webViewContainer.isHidden = true
            eventContainer.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            let w = (UIScreen.main.bounds.width - 40)/2
            return CGSize(width: w, height: 45)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
            return 10
      
     
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
       
    }
    
    
    
   

}
