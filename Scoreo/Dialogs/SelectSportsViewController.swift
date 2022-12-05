//
//  SelectSportsViewController.swift
//  Scoreo
//
//  Created by Remya on 10/28/22.
//

import UIKit
import SwiftEntryKit

class Sports{
    var name:String
    var icon:UIImage
    init(name:String,image:UIImage){
        self.name = name
        self.icon = image
    }
}

class SelectSportsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTop: UILabel!
    
    var sports = [Sports]()
    var selectedSport = 0
    var sportSelected:((Int)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

        // Do any additional setup after loading the view.
    }
    
    func initialSettings(){
        lblTop.text = "Choose your game".localized
        tableView.register(UINib(nibName: "SportsSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        let football = Sports(name: "Football".localized, image: UIImage(named: "football")!)
        sports.append(football)
        let basketball = Sports(name: "Basketball".localized, image: UIImage(named: "basketball")!)
        sports.append(basketball)
        tableView.reloadData()
        tableView.selectRow(at: IndexPath(row: selectedSport, section: 0), animated: false, scrollPosition: .top)
    }
    
    static func instance()-> SelectSportsViewController
    {
        let storyboard = UIStoryboard.init(name: "Dialogs", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SelectSportsViewController") as! SelectSportsViewController
        return vc
    }

}


extension SelectSportsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SportsSelectionTableViewCell
        cell.configureCell(obj: sports[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SwiftEntryKit.dismiss()
        sportSelected?(indexPath.row)
    }
}
