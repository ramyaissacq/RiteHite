//
//  WebViewViewController.swift
//  Core Score
//
//  Created by Remya on 10/11/22.
//

import UIKit
import WebKit

class WebViewViewController: BaseViewController {
    @IBOutlet weak var webView:WKWebView!
    
    var fromStart = false
   var urlString = ""
    var specialStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
        
        // Do any additional setup after loading the view.
    }
    
    func initialSettings(){
        
        if specialStart {
            self.navigationController?.navigationBar.isHidden = true
        }
        else{
            
            setupSpecialButtons()
            
            
        }
        loadUrl()
    }
    
    func setupSpecialButtons(){
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    @objc func backAction(){
        AppPreferences.setIsSearched(value: false)
        if fromStart{
        Utility.gotoHome()
        Utility.callURlDetailsAPI()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    

    func loadUrl(){
        if let link = URL(string:urlString){
        let request = URLRequest(url: link)
        webView.load(request)
        }
    }

}
