//
//  MatchCollectionViewCell.swift
//  Scoreo
//
//  Created by Remya on 10/26/22.
//

import UIKit

class MatchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var oddsBackView: UIView!
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblHomeName: UILabel!
    
    @IBOutlet weak var lblAwayName: UILabel!
    
    @IBOutlet weak var lblHomeScore: UILabel!
    @IBOutlet weak var lblAwayScore: UILabel!
    
    @IBOutlet weak var lblHomeYellow: UILabel!
    @IBOutlet weak var lblAwayYellow: UILabel!
    @IBOutlet weak var lblHomeRed: UILabel!
    @IBOutlet weak var lblAwayRed: UILabel!
    @IBOutlet weak var imgHomeLogo: UIImageView!
    @IBOutlet weak var imgAwayLogo: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblHalfTime: UILabel!
    @IBOutlet weak var lblCorner: UILabel!
    @IBOutlet weak var lblHandicap1: UILabel!
    @IBOutlet weak var lblHandicap2: UILabel!
    @IBOutlet weak var lblHandicap3: UILabel!
    @IBOutlet weak var lblOverUnder1: UILabel!
    @IBOutlet weak var lblOverUnder2: UILabel!
    @IBOutlet weak var lblOverUnder3: UILabel!
   
    @IBOutlet weak var odds2Stack: UIStackView!
    @IBOutlet weak var odds1Stack: UIStackView!
    @IBOutlet weak var tableViewQuarters: UITableView!
    @IBOutlet weak var homeCardView: UIView!
    @IBOutlet weak var cornerStack: UIView!
    
    @IBOutlet weak var awayCardView: UIView!
    
    var quarters = ["Q1","Q2","Q3","Q4","F"]
    var homeScores = [String]()
    var awayScores = [String]()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableViewQuarters.delegate = self
        tableViewQuarters.dataSource = self
        tableViewQuarters.register(UINib(nibName: "GeneralRowTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func configureCell(obj:MatchList?){
        tableViewQuarters.isHidden = true
        homeCardView.isHidden = false
        awayCardView.isHidden = false
        cornerStack.isHidden = false
        lblName.text = obj?.leagueNameShort
        lblHomeName.text = obj?.homeName
        lblAwayName.text = obj?.awayName
        lblHomeScore.text = "\(obj?.homeScore ?? 0 )"
        lblAwayScore.text = "\(obj?.awayScore ?? 0)"
        lblHomeYellow.text = "\(obj?.homeYellow ?? 0)"
        lblAwayYellow.text = "\(obj?.awayYellow ?? 0)"
        lblHomeRed.text = "\(obj?.homeRed ?? 0)"
        lblAwayRed.text = "\(obj?.awayRed ?? 0)"
        imgAwayLogo.setImage(with: obj?.awayLogo, placeholder: Utility.getPlaceHolder())
        imgHomeLogo.setImage(with: obj?.homeLogo, placeholder: Utility.getPlaceHolder())
        let mins = ScoresTableViewCell.timeInMins(startDate: obj?.startTime ?? "")
        if obj?.state == -1{
            lblTime.text = ScoresTableViewCell.getStatus(state: obj?.state ?? 0)
        }
        else{
        lblTime.text = "\(ScoresTableViewCell.getStatus(state: obj?.state ?? 0)) \(mins)'"
        }
        if obj?.state == 0{
            let matchDate = Utility.getSystemTimeZoneTime(dateString: obj?.matchTime ?? "")
            lblTime.text = Utility.formatDate(date: matchDate, with: .hhmm2)
        }

        
        var halfScore = ""
        var corner = ""
        if obj?.homeHalfScore == "0" && obj?.awayHalfScore == "0"{
            halfScore = ""
        }
        else{
            halfScore = "HT = \(obj?.homeHalfScore ?? "") : \(obj?.awayHalfScore ?? "")"
        }
        if obj?.homeCorner == "0" && obj?.awayCorner == "0"{
            corner = ""
        }
        else{
        corner = "C = \(obj?.homeCorner ?? "") : \(obj?.awayCorner ?? "")"
        }
        lblCorner.text = corner
        lblHalfTime.text = halfScore
        
        if obj?.odds?.handicap?.count ?? 0 > 7{
        lblHandicap1.text = String(obj?.odds?.handicap?[6] ?? 0)
        lblHandicap2.text = String(obj?.odds?.handicap?[5] ?? 0)
        lblHandicap3.text = String(obj?.odds?.handicap?[7] ?? 0)
            odds1Stack.isHidden = false
        }
        else{
            odds1Stack.isHidden = true
        }
        if obj?.odds?.overUnder?.count ?? 0 > 7{
        lblOverUnder1.text = String(obj?.odds?.overUnder?[6] ?? 0)
        lblOverUnder2.text = String(obj?.odds?.overUnder?[5] ?? 0)
        lblOverUnder3.text = String(obj?.odds?.overUnder?[7] ?? 0)
            odds2Stack.isHidden = false
        }
        else{
            odds2Stack.isHidden = true
        }
        
        if (obj?.odds?.overUnder?.isEmpty ?? true) && (obj?.odds?.handicap?.isEmpty ?? true){
            oddsBackView.isHidden = true
        }
        else{
            oddsBackView.isHidden = false
        }
      
      
    }
    
    
    func configureCell(obj:BasketballMatchList?){
        
        tableViewQuarters.isHidden = false
        homeCardView.isHidden = true
        awayCardView.isHidden = true
        cornerStack.isHidden = true
        switch Utility.getCurrentLang(){
        case "en":
            lblName.text = obj?.leagueNameShortEn
            lblHomeName.text = obj?.homeTeamEn
            lblAwayName.text = obj?.awayTeamEn
        case "cn":
            lblName.text = obj?.leagueNameShortCn
            lblHomeName.text = obj?.homeTeamNameCn
            lblAwayName.text = obj?.awayTeamNameCn
        case "id":
            lblName.text = obj?.leagueNameShortId
            lblHomeName.text = obj?.homeTeamNameId
            lblAwayName.text = obj?.awayTeamNameId
        case "vi":
            lblName.text = obj?.leagueNameShortVi
            lblHomeName.text = obj?.homeTeamNameVi
            lblAwayName.text = obj?.awayTeamNameVi
        case "th":
            lblName.text = obj?.leagueNameShortTh 
            lblHomeName.text = obj?.homeTeamNameTh
            lblAwayName.text = obj?.awayTeamNameTh
        default:
            break
        
        
        }
        
        let mins = ScoresTableViewCell.timeInMins(startDate: obj?.matchTime ?? "")
        if obj?.matchState == -1{
            lblTime.text = ScoresTableViewCell.getBasketballStatus(state: obj?.matchState ?? 0)
        }
        else{
        lblTime.text = "\(ScoresTableViewCell.getBasketballStatus(state: obj?.matchState ?? 0)) \(mins)'"
        }
        if obj?.matchState == 0{
            let matchDate = Utility.getSystemTimeZoneTime(dateString: obj?.matchTime ?? "")
            lblTime.text = Utility.formatDate(date: matchDate, with: .hhmm2)
        }
       
        lblHandicap1.text = String(obj?.odds?.moneyLineAverage?.liveHomeWinRate ?? 0)
        if obj?.odds?.spread?.count ?? 0 > 9{
            lblHandicap2.text = String(obj?.odds?.spread?[9] ?? 0)
        }
        else{
            lblHandicap2.text = ""
        }
        if obj?.odds?.total?.count ?? 0 > 9{
        lblHandicap3.text = String(obj?.odds?.total?[9] ?? 0)
        }
        else{
            lblHandicap3.text = ""
        }
        
        lblOverUnder1.text = String(obj?.odds?.moneyLineAverage?.liveAwayWinRate ?? 0)
    
        if obj?.odds?.spread?.count ?? 0 > 10{
        lblOverUnder2.text = String(obj?.odds?.spread?[10] ?? 0)
        }
        else{
            lblOverUnder2.text = ""
        }
        if obj?.odds?.total?.count ?? 0 > 10{
        lblOverUnder3.text = String(obj?.odds?.total?[10] ?? 0)
        }
        else{
            lblOverUnder3.text = ""
        }
        if (obj?.odds?.spread?.isEmpty ?? true) && (obj?.odds?.total?.isEmpty ?? true){
            odds1Stack.isHidden = true
            odds2Stack.isHidden = true
            oddsBackView.isHidden = true
        }
        else{
            odds1Stack.isHidden = false
            odds2Stack.isHidden = false
            oddsBackView.isHidden = false

        }
        
       
        
        if (obj?.odds?.spread?.isEmpty ?? true) && (obj?.odds?.total?.isEmpty ?? true){
            odds1Stack.isHidden = true
            odds2Stack.isHidden = true
            
        }
        else{
            odds1Stack.isHidden = false
            odds2Stack.isHidden = false
            

        }
        homeScores = [obj?.home1 ?? "",obj?.home2 ?? "",obj?.home3 ?? "",obj?.home4 ?? "",obj?.homeScore ?? ""]
        awayScores = [obj?.away1 ?? "",obj?.away2 ?? "",obj?.away3 ?? "",obj?.away4 ?? "",obj?.awayScore ?? ""]
        tableViewQuarters.reloadData()
        
        
        
    }

}


extension MatchCollectionViewCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GeneralRowTableViewCell
        
        if indexPath.row == 0{
            cell.titleType = .Header(color: Colors.accentColor())
            cell.backgroundColor = .clear
        }
       else if indexPath.row == 1{
           cell.titleType = .Bold
           cell.backgroundColor = .clear
       }
        else{
            cell.titleType = .Normal
            cell.backgroundColor = .clear
        }
        cell.headerSizes = calculateWidth()
        cell.height = 30
        cell.spacing = 0
        cell.collectionHeight.constant = 30
        if indexPath.row == 0{
        cell.values = quarters
        }
        else if indexPath.row == 1{
            cell.values = homeScores
        }
        else{
            cell.values = awayScores
        }
        return cell
        
    }
    
    func calculateWidth()->[CGFloat]{
        let w = (UIScreen.main.bounds.width - 40)/2
        let width = w/CGFloat(quarters.count)
        var sizes = [CGFloat]()
        for _ in 0...quarters.count-1{
            sizes.append(width)
        }
        return sizes
    }
    
    
}
