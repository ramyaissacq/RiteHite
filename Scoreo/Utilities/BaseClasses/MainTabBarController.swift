//
//  MainTabBarController.swift
//  Scoreo
//
//  Created by Remya on 10/29/22.
//

import Foundation
import UIKit
class MainTabBarController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()

        let tabbarBackgroundView = RoundShadowView(frame: tabBar.frame)
        tabbarBackgroundView.cornerRadius = 25
        tabbarBackgroundView.backgroundColor = .red
        tabbarBackgroundView.frame = tabBar.frame
        view.addSubview(tabbarBackgroundView)

        let fillerView = UIView()
        fillerView.frame = tabBar.frame
        fillerView.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        fillerView.backgroundColor = .white
        view.addSubview(fillerView)

        view.bringSubviewToFront(tabBar)
    }
}
