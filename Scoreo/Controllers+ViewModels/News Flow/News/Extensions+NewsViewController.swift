//
//  Extensions+NewsViewController.swift
//  775775Sports
//
//  Created by Remya on 9/2/22.
//

import Foundation
import UIKit

//MARK: - UICollectionView Delegates

extension NewsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewHeader{
            return headers.count
        }
        else if collectionView == collectionViewTop{
            return viewModel.topNewsList?.count ?? 0
        }
        else if selectedHeaderIndex == 0{
            return (viewModel.newsList?.count ?? 0) + 1
        }
        else{
            return (viewModel.videoList?.count ?? 0) + 1
        }
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewHeader{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCollectionViewCell", for: indexPath) as! SelectionCollectionViewCell
            cell.lblTitle.text = headers[indexPath.row]
            return cell
        }
        else if collectionView == collectionViewTop{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsGamesCollectionViewCell", for: indexPath) as! NewsGamesCollectionViewCell
            cell.configureCell(obj: viewModel.topNewsList?[indexPath.row])
            return cell
            
        }
        else{
            if selectedHeaderIndex == 0{
                if indexPath.row == (viewModel.newsList?.count ?? 0) && newsPage <= (viewModel.newsPageData?.lastPage ?? 0){
                    viewModel.getNews(page: newsPage)
                    let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "LoaderCollectionViewCell", for: indexPath) as! LoaderCollectionViewCell
                    cell.activity.startAnimating()
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as! LatestNewsCollectionViewCell
                cell.configureCell(obj: viewModel.newsList?[indexPath.row])
                return cell
            }
            else{
                if indexPath.row == (viewModel.videoList?.count ?? 0) && videoPage <= (viewModel.videoPageData?.lastPage ?? 0){
                    viewModel.getVideos(page: videoPage)
                    let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "LoaderCollectionViewCell", for: indexPath) as! LoaderCollectionViewCell
                    cell.activity.startAnimating()
                    return cell
                }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoHeighlightsCollectionViewCell", for: indexPath) as! VideoHeighlightsCollectionViewCell
            cell.configureCell(obj: viewModel.videoList?[indexPath.row])
            return cell
            }
        }
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewHeader{
            self.selectedHeaderIndex = indexPath.row
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.setupViews()
        }
        else if collectionView == collectionViewTop{
            if indexPath.row < (viewModel.topNewsList?.count ?? 0){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
            vc.newsID = viewModel.topNewsList?[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        else{
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
                vc.viewModel.originalVideoList = viewModel.originalVideoList
                vc.viewModel.videoPageData = viewModel.videoPageData
                vc.videoPage = videoPage
                self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewHeader{
            let w = (UIScreen.main.bounds.width - 40) / 2
            return CGSize(width: w, height: 40)
        }
        else if collectionView == collectionViewTop{
            let w = UIScreen.main.bounds.width * 0.7
            return CGSize(width: w, height: 250)
        }
        else{
            if selectedHeaderIndex == 0{
                if indexPath.row == (viewModel.newsList?.count ?? 0){
                    let w = UIScreen.main.bounds.width - 40
                    return CGSize(width: w, height: 40)
                }
            let w = (UIScreen.main.bounds.width - 50) / 2
            return CGSize(width: w, height: 220)
            }
            else{
                if indexPath.row == (viewModel.videoList?.count ?? 0){
                    let w = UIScreen.main.bounds.width - 40
                    return CGSize(width: w, height: 40)
                }
                let w = UIScreen.main.bounds.width - 40
                return CGSize(width: w, height: 250)
            }
        }
       
    }
    
}


////MARK: - UITableView Delegates
//
//extension NewsViewController:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if selectedHeaderIndex == 0{
//            return viewModel.newsList?.count ?? 0
//        }
//        else{
//            return viewModel.videoList?.count ?? 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if selectedHeaderIndex == 0{
//            if indexPath.row == ((viewModel.newsList?.count ?? 0) - 1) && newsPage <= (viewModel.newsPageData?.lastPage ?? 0){
//                viewModel.getNews(page: newsPage)
//                let cell = tableView.dequeueReusableCell(withIdentifier: "loaderCell", for: indexPath) as! LoaderTableViewCell
//                cell.activity.startAnimating()
//                return cell
//            }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
//            cell.configureCell(obj: viewModel.newsList?[indexPath.row])
//            return cell
//        }
//        else{
//            if indexPath.row == ((viewModel.videoList?.count ?? 0) - 1) && videoPage <= (viewModel.videoPageData?.lastPage ?? 0){
//                viewModel.getVideos(page: videoPage)
//                let cell = tableView.dequeueReusableCell(withIdentifier: "loaderCell", for: indexPath) as! LoaderTableViewCell
//                cell.activity.startAnimating()
//                return cell
//            }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! HeighlightsTableViewCell
//            cell.configureCell(obj: viewModel.videoList?[indexPath.row])
//            return cell
//
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if selectedHeaderIndex == 0{
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
//            vc.newsID = viewModel.newsList?[indexPath.row].id
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        else{
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HighlightsDetailsViewController") as! HighlightsDetailsViewController
//            vc.selectedVideo = viewModel.videoList?[indexPath.row]
//            vc.viewModel.videoList = viewModel.videoList
//            vc.viewModel.originalVideoList = viewModel.originalVideoList
//            vc.viewModel.videoPageData = viewModel.videoPageData
//            vc.videoPage = videoPage
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//
//}



