//
//  NewsSearchViewController.swift
//  Scoreo
//
//  Created by Remya on 10/27/22.
//

import UIKit

class NewsSearchViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Variables
    var viewModel = NewsViewModel()
    var page = 1
    var selectedHeaderIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        intialSettings()

        // Do any additional setup after loading the view.
    }
    
    func setupNavBar(){
        self.navigationItem.titleView = getGradientHeaderLabel(title: "Search".localized)
        setBackButton()
        
    }
    func intialSettings(){
        searchBar.placeholder = "Search".localized
        setupNavBar()
        collectionView.registerCell(identifier: "VideoHeighlightsCollectionViewCell")
        collectionView.registerCell(identifier: "LatestNewsCollectionViewCell")
        collectionView.registerCell(identifier: "LoaderCollectionViewCell")
       
        viewModel.delegate = self
        
        
        
    }
   

}

//MARK: NewsViewModelDelegates
extension NewsSearchViewController:NewsViewModelDelegates{
    
func didFinishFetchNews() {
    page += 1
   filterLists()
    
}

func didFinishFetchVideos() {
    page += 1
   filterLists()
    
}
    
    func filterLists(){
       
            if selectedHeaderIndex == 0{
                self.viewModel.newsList?.removeAll()
                self.viewModel.newsList = self.viewModel.originalNewsList?.filter{$0.title?.lowercased().contains(searchBar.text?.lowercased() ?? "") ?? false}
                
            }
            else{
                self.viewModel.videoList?.removeAll()
                self.viewModel.videoList = self.viewModel.originalVideoList?.filter{$0.title?.contains(searchBar.text ?? "") ?? false}
            }
            
        
        
        collectionView.reloadData()
        
    }
}


//MARK: - UISearchbar Delegates

extension NewsSearchViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            actionCancelSearch()
        }
        else{
            filterLists()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        actionCancelSearch()
        
    }
    
    func actionCancelSearch(){
        if selectedHeaderIndex == 0{
            self.viewModel.newsList?.removeAll()
            self.viewModel.newsList = self.viewModel.originalNewsList
        }
        else{
            self.viewModel.videoList?.removeAll()
            self.viewModel.videoList = self.viewModel.originalVideoList
        }
        collectionView.reloadData()
    }
}


//MARK: - UICollectionView Delegates

extension NewsSearchViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         if selectedHeaderIndex == 0{
            return (viewModel.newsList?.count ?? 0)
        }
        else{
            return (viewModel.videoList?.count ?? 0)
        }
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            if selectedHeaderIndex == 0{
                if indexPath.row == ((viewModel.newsList?.count ?? 0) - 1) && page <= (viewModel.newsPageData?.lastPage ?? 0){
                    viewModel.getNews(page: page)
                    let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "LoaderCollectionViewCell", for: indexPath) as! LoaderCollectionViewCell
                    cell.activity.startAnimating()
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as! LatestNewsCollectionViewCell
                cell.configureCell(obj: viewModel.newsList?[indexPath.row])
                return cell
            }
            else{
                if indexPath.row == ((viewModel.videoList?.count ?? 0) - 1) && page <= (viewModel.videoPageData?.lastPage ?? 0){
                    viewModel.getVideos(page: page)
                    let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "LoaderCollectionViewCell", for: indexPath) as! LoaderCollectionViewCell
                    cell.activity.startAnimating()
                    return cell
                }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoHeighlightsCollectionViewCell", for: indexPath) as! VideoHeighlightsCollectionViewCell
            cell.configureCell(obj: viewModel.videoList?[indexPath.row])
            return cell
            }
        
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            if selectedHeaderIndex == 0{
                if indexPath.row < (viewModel.newsList?.count ?? 0){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
                vc.newsID = viewModel.newsList?[indexPath.row].id
                self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                if indexPath.row < (viewModel.videoList?.count ?? 0){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HighlightsDetailsViewController") as! HighlightsDetailsViewController
                vc.selectedVideo = viewModel.videoList?[indexPath.row]
                vc.viewModel.videoList = viewModel.videoList
                vc.viewModel.originalVideoList = viewModel.videoList
                vc.viewModel.videoPageData = viewModel.videoPageData
                vc.videoPage = page
                self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            if selectedHeaderIndex == 0{
                if indexPath.row == ((viewModel.newsList?.count ?? 0) - 1){
                    let w = UIScreen.main.bounds.width - 40
                    return CGSize(width: w, height: 40)
                }
            let w = (UIScreen.main.bounds.width - 50) / 2
            return CGSize(width: w, height: 220)
            }
            else{
                if indexPath.row == ((viewModel.videoList?.count ?? 0) - 1){
                    let w = UIScreen.main.bounds.width - 40
                    return CGSize(width: w, height: 40)
                }
                let w = UIScreen.main.bounds.width - 40
                return CGSize(width: w, height: 250)
            }
        
       
    }
    
}
