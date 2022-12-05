

import UIKit
import SideMenu

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarColor()
    }
    
    func setTitleMargin()
    {
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 5
        navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [NSAttributedString.Key.paragraphStyle : style]
    }
    
    func setNavBarColor(color:UIColor = Colors.screenColor())
    {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.removeBottomLine()
        let yourBackImage = UIImage(named: "back")
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.setBackIndicatorImage(yourBackImage, transitionMaskImage: yourBackImage)
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = color
        navBarAppearance.shadowColor = .clear
        self.navigationController?.navigationBar.tintColor = Colors.backgroundColor()
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
       
    }
    
    func makeTransparentBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        UINavigationBar.appearance().standardAppearance = appearance
        
    }
    
   
    
    func setTitle(title:String){
        self.navigationItem.titleView = getHeaderLabel(title: title)
    }
    
    func getHeaderLabel(title:String) -> UILabel{
        let w = title.width(forHeight: 25, font: UIFont(name: "SFProText-Bold", size: 23)!)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 20))
        label.text = title
        label.font = UIFont(name: "SFProText-Bold", size: 23)
        label.textColor = .white
        return label
    }
    
   
   
    func getGradientHeaderLabel(title:String) -> UILabel{
        let w = title.width(forHeight: 25, font: UIFont(name: "SFProText-Bold", size: 23)!)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 20))
        label.text = title
        label.font = UIFont(name: "SFProText-Bold", size: 23)
        let gradient = label.getGradientLayer(bounds: label.bounds)
        label.textColor = label.gradientColor(bounds: label.bounds, gradientLayer: gradient)
        return label
    }
    
    func setCustomNavBarColor(color:UIColor){
        self.navigationController?.navigationBar.backgroundColor = color
        self.navigationController?.navigationBar.barTintColor = color
    }
    
   static func openSideMenu(vc:UIViewController){
        let sideMenuVc = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController")
        let menu = SideMenuNavigationController(rootViewController: sideMenuVc)
       menu.leftSide = true
       menu.menuWidth = UIScreen.main.bounds.width - 50
       menu.navigationBar.isHidden = true
        menu.statusBarEndAlpha = 0
        vc.present(menu, animated: true)
    }
        

    
}
