//
//  LaunchesViewController.swift
//  Scoreo
//
//  Created by Remya on 11/18/22.
//

import UIKit
import MOLH

class LaunchesViewController: UIViewController {
    var timer = Timer()
    var urlData:UrlDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callURlDetailsAPI()
        configureTimer()

        // Do any additional setup after loading the view.
    }
    
    func configureTimer(){
       
       timer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction(){
        if urlData == nil{
            self.initialLoad()
            timer.invalidate()
        }
       
    }
    

     func callURlDetailsAPI(){
        HomeAPI().getUrlInfo { response in
            self.urlData = response
            print("I Got Response")
            if response.initField?.openType?.count ?? 0 > 0{
                if response.initField?.openType == "0"{
                    self.openWebview(url: response.initField?.redirectUrl ?? "")
                }
                else{
                    guard let url = URL(string: response.initField?.redirectUrl ?? "") else{return}
                    Utility.openUrl(url: url)
                    self.initialLoad()
                }
                
            }
            else{
                self.initialLoad()
            }
            
        } failed: { _ in
            self.initialLoad()
        }

    }
    
    
    
    func initialLoad(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if AppPreferences.getIsSearched(){
            if AppPreferences.getMapObject()?.openType == "0"{
                self.openWebViewWithBack()
            }
            else{
                guard let url = URL(string: AppPreferences.getMapObject()?.redirectUrl ?? "") else{return}
                        Utility.openUrl(url: url)
                delegate?.setupLaunch()
            }
        }
        else{
            
            
            if delegate?.getPhoneLanguage() == "zh"{
                MOLHLanguage.setAppleLAnguageTo("zh-Hans")
                MOLH.reset()
            }
            else{
                delegate?.setupLaunch()
            }
            
        }
    }
    
    func openWebViewWithBack(){
            let navigation = UINavigationController()
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
            vc.urlString = AppPreferences.getMapObject()?.redirectUrl ?? ""
            vc.fromStart = true
            navigation.viewControllers = [vc]
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = navigation
            
        }
    
    func openWebview(url:String){
        let navigation = UINavigationController()
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        vc.urlString = url
        vc.specialStart = true
        navigation.viewControllers = [vc]
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = navigation
    }

}
