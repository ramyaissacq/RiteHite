//
//  KickOffViewController.swift
//  Scoreo
//
//  Created by Remya on 11/7/22.
//

import UIKit
import ImageSlideshow

class KickOffViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewMatch: UITableView!
    @IBOutlet weak var imageSlideshow:ImageSlideshow!
    let pageIndicator = UIPageControl()
    
    //MARK: - Variables
    var viewModel = KickOffViewModel()
    var page = 1
    var topTitles = ["ALL".localized,"LEAGUES".localized]
    var headerLabel = "Rite-Hite".localized
    static var urlDetails:UrlDetails?
    static var popupFlag = 1
    static var timer = Timer()
    static var fromLanguage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        KickOffViewController.popupFlag = 1
        setupLeftView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        KickOffViewController.popupFlag = 0
    }
    
    
    
    
    func initialSettings(){
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSlides), name: Notification.Name("RefreshSlideshow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        setupNavBar()
        searchBar.searchTextField.leftView?.tintColor = Colors.gray1Color()
        searchBar.placeholder = "Search".localized
        tableViewMatch.register(UINib(nibName: "SoonTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewMatch.register(UINib(nibName: "LiveMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "liveCell")
        tableViewMatch.register(UINib(nibName: "SectionHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "headerCell")
        tableViewMatch.register(UINib(nibName: "LoaderTableViewCell", bundle: nil), forCellReuseIdentifier: "loaderCell")
        tableViewMatch.register(UINib(nibName: "EmptySoonTableViewCell", bundle: nil), forCellReuseIdentifier: "emptyCell")
        tableViewMatch.register(UINib(nibName: "SlideshowTableViewCell", bundle: nil), forCellReuseIdentifier: "slideshowCell")
        viewModel.delegate = self
        viewModel.getMatchesList(page: page)
        
        
    }
    
    @objc func appWillEnterForeground() {
        KickOffViewController.popupFlag = 1
        setupLeftView()
    }
    
    @objc func refreshSlides(){
        if KickOffViewController.urlDetails?.mapping?.count ?? 0 > 0{
            setupSlideshow()
        }
       
    }
    
    
    
    func setupNavBar(){
        
        let rightBtn = getButton(image: UIImage(named: "menu")!)
        rightBtn.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        setupLeftView()
    }
    
    @objc func openMenu(){
        let vc = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupLeftView(){
        
        let leftLabel = getGradientHeaderLabel(title: "Rite-Hite".localized)
        if AppPreferences.getMapObject() != nil{
            let btn = getButton(image: UIImage(named: "next")!)
            let gradient = btn.getGradientLayer(bounds: btn.bounds)
            btn.backgroundColor = btn.gradientColor(bounds: btn.bounds, gradientLayer: gradient)
            btn.addTarget(self, action: #selector(specialButtonAction), for: .touchUpInside)
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: btn),UIBarButtonItem(customView: leftLabel)]
        }
        else{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftLabel)
        }
       
    }
    
    @objc func specialButtonAction() {
        if AppPreferences.getMapObject()?.openType == "0"{
            AppPreferences.setIsSearched(value: true)
            let urlString = AppPreferences.getMapObject()?.redirectUrl ?? ""
        gotoWebview(url: urlString)
        }
        else{
            AppPreferences.setIsSearched(value: false)
            guard let url = URL(string: AppPreferences.getMapObject()?.redirectUrl ?? "") else{return}
                    Utility.openUrl(url: url)
        }
        
    }
    
   
    
    static func configureTimer(){
        if KickOffViewController.urlDetails?.prompt?.repeat_status == 1{
        let time:Double = Double(KickOffViewController.urlDetails?.prompt?.repeat_time ?? 0)
       timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc static func timerAction(){
        if KickOffViewController.urlDetails?.prompt?.repeat_status == 1{
        KickOffViewController.openPrompt()
        }
    }
   
   
    static func showPopup(){
        
        NotificationCenter.default.post(name: Notification.Name("RefreshSlideshow"), object: nil)
        let frequency = AppPreferences.getPopupFrequency()
        if KickOffViewController.urlDetails?.prompt?.repeat_status == 1{
         openPrompt()
        
        }
        else{
        let promptFrequency = KickOffViewController.urlDetails?.prompt?.frequency ?? 0
        if frequency < promptFrequency{
            openPrompt()
            AppPreferences.setPopupFrequency(frequency: frequency+1)
        }
        }
    }
    
    static func openPrompt(){
        //
        if KickOffViewController.fromLanguage{
            KickOffViewController.fromLanguage = false
            configureTimer()
            return
        }
        if KickOffViewController.popupFlag == 1{
            timer.invalidate()
        let title = KickOffViewController.urlDetails?.prompt?.title ?? ""
        let message = KickOffViewController.urlDetails?.prompt?.message ?? ""
            let btnText = KickOffViewController.urlDetails?.prompt?.button ?? "OK".localized
        Dialog.openSpecialSuccessDialog(buttonLabel: btnText, title: title, msg: message, completed: {}, tapped: {
            configureTimer()
            if KickOffViewController.urlDetails?.prompt?.redirect_url?.count ?? 0 > 0{
            var mapObj = Mapping()
            mapObj.openType = KickOffViewController.urlDetails?.prompt?.open_type
            mapObj.redirectUrl = KickOffViewController.urlDetails?.prompt?.redirect_url
            AppPreferences.setMapObject(obj: mapObj)
            }
            else{
                return
            }
            
            if KickOffViewController.urlDetails?.prompt?.open_type == "0"{
                AppPreferences.setIsSearched(value: true)
                let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
                
                    vc.urlString = KickOffViewController.urlDetails?.prompt?.redirect_url ?? ""
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                if let nav = appDelegate?.window?.rootViewController as? UINavigationController{
                nav.pushViewController(vc, animated: true)
                }
            }
            else{
                AppPreferences.setIsSearched(value: false)
                guard let url = URL(string: KickOffViewController.urlDetails?.prompt?.redirect_url ?? "") else{return}
                Utility.openUrl(url: url)
            }
            
        }, closed: {
            configureTimer()
        })
        }
    }
    
    
    func setupSlideshow(){
       
        pageIndicator.currentPageIndicatorTintColor =  Colors.accentColor()
        pageIndicator.pageIndicatorTintColor = UIColor.black
        pageIndicator.numberOfPages = KickOffViewController.urlDetails?.banner?.count ?? 0
        imageSlideshow.pageIndicator = pageIndicator
        imageSlideshow.contentScaleMode = .scaleAspectFill
        imageSlideshow.slideshowInterval = 2
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlideshow.addGestureRecognizer(gestureRecognizer)
        if KickOffViewController.urlDetails?.banner?.count ?? 0 > 0{
            var images = [InputSource]()
            for m in KickOffViewController.urlDetails?.banner ?? []{
                if let src = KingfisherSource(urlString: m.image ?? ""){
                    images.append(src)
                }
            }
            imageSlideshow.setImageInputs(images)
            imageSlideshow.isHidden = false
        }
        else{
            imageSlideshow.isHidden = true
        }
       
    }
    
    
    @objc func didTap(){
        let index = pageIndicator.currentPage
        let banner = KickOffViewController.urlDetails?.banner?[index]
        var mapObj = Mapping()
        mapObj.openType = banner?.openType
        mapObj.redirectUrl = banner?.redirectUrl
        AppPreferences.setMapObject(obj: mapObj)
        if banner?.openType == "0"{
            AppPreferences.setIsSearched(value: true)
        gotoWebview(url: banner?.redirectUrl ?? "")
        }
        else{
            AppPreferences.setIsSearched(value: false)
            guard let url = URL(string: banner?.redirectUrl ?? "") else{return}
            Utility.openUrl(url: url)
        }
        
    }
    
 
}


extension KickOffViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.liveMatches?.count ?? 0 > 0{
          return viewModel.liveMatches?.count ?? 0
        }
        else{
          return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            
            if viewModel.liveMatches?.count ?? 0 > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SoonTableViewCell
            cell.configureCell(obj: viewModel.liveMatches?[indexPath.row])
            return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as! EmptySoonTableViewCell
                return cell
            }
                
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layoutIfNeeded()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            if viewModel.liveMatches?.count ?? 0 > 0{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LinupViewController") as! LinupViewController
        vc.match = viewModel.liveMatches?[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
            }
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section < 2{
//        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! SectionHeaderTableViewCell
//        cell.lblTitle.text = sectionHeaders[section]
//        return cell
//        }
//        return nil
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
}





extension KickOffViewController:KickOffViewModelDelegate{
    func didFinishFilterByLeague() {
        prepareDisplays()
    }
    
    func getCurrentPage() -> Int {
        return page
    }
    
   
    
    
    func diFinisfFetchMatches() {
        page += 1
        prepareDisplays()
       
        
    }
    
    
    func prepareDisplays(){
        applySearch()
        prepareViews()
    }
    
    func applySearch(){
        if !(searchBar.text?.isEmpty ?? false) {
            doSearch(searchText: searchBar.text ?? "")
        }
    }
    
    func prepareViews(){
        tableViewMatch.reloadData()
    }
   
}
