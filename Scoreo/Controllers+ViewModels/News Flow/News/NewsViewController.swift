//
//  NewsViewController.swift
//  775775Sports
//
//  Created by Remya on 9/2/22.
//

import UIKit

class NewsViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionViewHeader: UICollectionView!
    @IBOutlet weak var collectionViewBottom: UICollectionView!
    @IBOutlet weak var collectionViewTop: UICollectionView!
    @IBOutlet weak var headerView1: UIView!
    @IBOutlet weak var headerView2: UIView!
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var fixedLblHandPicks: UILabel!
    @IBOutlet weak var fixedLatest: UILabel!
    
    //@IBOutlet weak var collectionViewNewsHeight: NSLayoutConstraint!
    
    //MARK: - Variables
    var collectionViewNewsObserver: NSKeyValueObservation?
    var headers = ["News".localized,"Highlights".localized]
    var selectedHeaderIndex = 0
    var viewModel = NewsViewModel()
    var newsPage = 2
    var videoPage = 1
    var refreshControl:UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionViewHeader.selectItem(at: IndexPath(row: selectedHeaderIndex, section: 0), animated: false, scrollPosition: .left)
    }

    func setupNavBar(){
       
        let lbl = getHeaderLabel(title: "News".localized)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: lbl)
        let searchBtn = getButton(image: UIImage(named: "search")!)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
        searchBtn.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
        self.navigationItem.titleView = nil
       
    }
    
    @objc func actionSearch(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsSearchViewController") as! NewsSearchViewController
        vc.selectedHeaderIndex = selectedHeaderIndex
        if selectedHeaderIndex == 0{
            vc.page = newsPage
        }
        else{
            vc.page = videoPage
        }
        
        let vm = NewsViewModel()
        vm.originalVideoList = viewModel.originalVideoList
        vm.originalNewsList = viewModel.originalNewsList
        vm.newsPageData = viewModel.newsPageData
        vm.videoPageData = viewModel.videoPageData
        vc.viewModel = vm
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    func intialSettings(){
        setupNavBar()
        fixedLblHandPicks.text = "Hand Picks".localized
        fixedLatest.text = "Latest".localized
        collectionViewHeader.registerCell(identifier: "SelectionCollectionViewCell")
        collectionViewTop.registerCell(identifier: "NewsGamesCollectionViewCell")
        collectionViewBottom.registerCell(identifier: "VideoHeighlightsCollectionViewCell")
        collectionViewBottom.registerCell(identifier: "LatestNewsCollectionViewCell")
        collectionViewBottom.registerCell(identifier: "LoaderCollectionViewCell")
//        collectionViewNewsObserver = collectionViewBottom.observe(\.contentSize, options: .new) { (_, change) in
//            guard let height = change.newValue?.height else { return }
//            self.collectionViewNewsHeight.constant = height
//        }
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .clear
        refreshControl?.addTarget(self, action: #selector(refreshViews), for: .valueChanged)
       collectionViewBottom.refreshControl = refreshControl
        setupViews()
        viewModel.delegate = self
        viewModel.getNews(page: 1)
        viewModel.getNews(page: newsPage)
        viewModel.getVideos(page: videoPage)
        
        
    }
    
    
    
    func setupViews(){
        
        collectionViewTop.reloadData()
        collectionViewBottom.reloadData()
        
        if selectedHeaderIndex == 0{
            topStack.isHidden = false
        }
        else{
            topStack.isHidden = true
        }
        
        
    }
    
    @objc func refreshViews(){
        newsPage = 2
        videoPage = 1
        viewModel.getNews(page: newsPage)
        viewModel.getVideos(page: videoPage)
    }

}

//MARK: NewsViewModelDelegates
extension NewsViewController:NewsViewModelDelegates{
    func didFinishTopNewsFetch(){
        collectionViewTop.reloadData()
    }
    
func didFinishFetchNews() {
    
    newsPage += 1
    self.viewModel.newsList = self.viewModel.originalNewsList
    
    collectionViewBottom.reloadData()
    if viewModel.newsList?.count ?? 0 > 0{
        emptyView.isHidden = true
    }
    else{
        emptyView.isHidden = false
    }
    
}

func didFinishFetchVideos() {
    videoPage += 1
    self.viewModel.videoList = self.viewModel.originalVideoList
    collectionViewBottom.reloadData()
    if viewModel.videoList?.count ?? 0 > 0{
        emptyView.isHidden = true
    }
    else{
        emptyView.isHidden = false
    }
    
}
    
   
}

