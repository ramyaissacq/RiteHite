//
//  KickOffViewModel.swift
//  Scoreo
//
//  Created by Remya on 11/7/22.
//

import Foundation


protocol KickOffViewModelDelegate{
    
    func diFinisfFetchMatches()

    func getCurrentPage()->Int
    func didFinishFilterByLeague()
}

class KickOffViewModel{
    var matches:[MatchList]?
    var OriginalLiveMatches:[MatchList]?
    var liveMatches:[MatchList]?
    var pageData:Meta?
    var scoreResponse:ScoresResponse?
    var delegate:KickOffViewModelDelegate?
    
    func getMatchesList(page:Int){
        // Utility.showProgress()
        print("PAGE::\(page)")
      
        HomeAPI().getScores(page: page) { response in
            self.scoreResponse = response
            if page > 1 {
                var tempMatches = self.matches ?? []
                tempMatches.append(contentsOf: response.matchList ?? [])
                self.matches = tempMatches
                
            }
            else{
               
                self.matches?.removeAll()
                self.matches = response.matchList
                
            }
            self.filterMatches()
            self.delegate?.diFinisfFetchMatches()
            
            self.pageData = response.meta
            let page = self.delegate!.getCurrentPage()
            if page <= (self.pageData?.lastPage ?? 0){
                self.getMatchesList(page: page)
            }
           
        } failed: { msg in
          //  Utility.showErrorSnackView(message: msg)
        }
        
    }
    
    
    
    
}

extension KickOffViewModel{
    func filterMatches(){

        liveMatches = matches?.filter{(($0.havAnim ?? false) || ($0.havEvent ?? false))}
        OriginalLiveMatches = liveMatches
      
    }
}
