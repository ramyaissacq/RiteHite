//
//  SideMenuViewController.swift
//  Core Score
//
//  Created by Remya on 9/29/22.
//

import UIKit
import MessageUI

class SideMenuViewController:BaseViewController{
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Language".localized,"Privacy Policy".localized,"Share App".localized,"Feed Back".localized,"Rate Us".localized]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    func initialSettings(){
        setupNavBar()
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func setupNavBar(){
        let lbl = getGradientHeaderLabel(title: "Settings".localized)
        self.navigationItem.titleView = lbl
        setBackButton()
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["bequick.dev@gmail.com"])
            //mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            Utility.showErrorSnackView(message: "Mail is not configured on the device")
            // show failure alert
        }
    }
   

}


extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        cell.imgIcon.image = UIImage(named: "g\(indexPath.row+1)")
        //cell.imgIcon.setImageColor(color: Colors.accentColor())
        cell.lblTitle.text = menus[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let pagesVC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "PagesViewController") as! PagesViewController
        switch indexPath.row{
        case 0:
            openVC(storyBoard: "SideMenu", identifier: "LanguageViewController")
        case 1:
            
            Utility.openUrl(url: URL(string: "https://ritehite.wordpress.com/privacy-policy/")!)
            //ScorePro
        case 2:
            Utility.shareAction(text: "Install Rite-Hite from apple appstore", url: URL(string: ""), image: UIImage(named: "launch"), vc: self.parent!)
            
        case 3:
            sendEmail()
            
        case 4:
            Utility.rateApp(id: "6444954162")
            
            
        default:
            break
            
        }
    }
    
    
}


extension SideMenuViewController:MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
