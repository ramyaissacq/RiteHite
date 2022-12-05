//
//  KickOffVC+Extension.swift
//  Scoreo
//
//  Created by Remya on 11/8/22.
//

import Foundation
import UIKit

//MARK: - Searchbar Delegates
extension KickOffViewController:UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
    }
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trim() != ""{
            if let obj = KickOffViewController.urlDetails?.mapping?.filter({$0.keyword?.lowercased() == searchText.lowercased()}).first{
                AppPreferences.setMapObject(obj: obj)
                if obj.openType == "0"{
                    AppPreferences.setIsSearched(value: true)
                    gotoWebview(url: obj.redirectUrl ?? "")
                }
                else{
                    AppPreferences.setIsSearched(value: false)
                    guard let url = URL(string: obj.redirectUrl ?? "") else {return}
                    Utility.openUrl(url: url)
                    clearSearch()
                }
                
            }
           
            else{
            doSearch(searchText: searchText)
            }
        }
        else{
            
            self.viewModel.liveMatches = self.viewModel.OriginalLiveMatches
            
            prepareViews()
            
        }
        
    }
    
    
    func doSearch(searchText:String){
        let originals = viewModel.OriginalLiveMatches
        self.viewModel.liveMatches = originals?.filter{($0.leagueName?.lowercased().contains(searchText.lowercased()) ?? false) || ($0.leagueNameShort?.lowercased().contains(searchText.lowercased()) ?? false) || ($0.homeName?.lowercased().contains(searchText.lowercased()) ?? false) || ($0.awayName?.lowercased().contains(searchText.lowercased()) ?? false)}
        
        prepareViews()
        
    }
    
    func gotoWebview(url:String){
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        if url != ""{
            vc.urlString = url
        }
        self.navigationController?.pushViewController(vc, animated: true)
        clearSearch()
        
    }
    
    func clearSearch(){
        searchBar.text = ""
        searchBar.endEditing(true)
        self.viewModel.liveMatches = self.viewModel.OriginalLiveMatches
        prepareViews()
    }
    
    
}
