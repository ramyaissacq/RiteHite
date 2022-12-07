//
//  OnboardingViewController.swift
//  Core Score
//
//  Created by Remya on 9/30/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var current = 0
    var titles = ["Welcome to Rite-Hite".localized,"Lineups".localized,"Player Info".localized]
    
    var descriptions = ["Welcome to the last app you’ll download for all your sports related content! Kick-off your day with a bang with Rite-Hite and don’t miss a beat all day every day ".localized,"Is your favourite team taking to the field today? Check out their lineup and how they stack against the opponents! For every sport, we’ll have the lineups ready for your viewing pleasure the moment they’re announced, all without delay.".localized,"Lineups are nothing but meaningless stats without player info! You’ll get player details on the press of a button, their stats, their best performance, greatest triumphs and lowest points, as well as how they fit into the squad.".localized]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

        // Do any additional setup after loading the view.
    }
    
   
    
    func initialSettings(){
        collectionView.registerCell(identifier: "OnboardingCollectionViewCell")
        setupGestures()
        
    }
    
    func setupGestures(){
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        left.direction = .left
        left.delegate = self
        collectionView.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        right.direction = .right
        right.delegate = self
        collectionView.addGestureRecognizer(right)
        
    }
    
    func moveForward(){
        let total = titles.count
        if current < (total - 1){
            current += 1
            collectionView.scrollToItem(at: IndexPath(row: current, section: 0), at: .centeredHorizontally, animated: true)
        }
        else{
            Utility.gotoHome()
            Utility.callURlDetailsAPI()
        }
    }
    
    @objc func swipe(sender:UISwipeGestureRecognizer){
        
        if sender.direction == .left{
            moveForward()
        }
        else{
            if current > 0{
                current -= 1
                collectionView.scrollToItem(at: IndexPath(row: current, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
        
    }
}


extension OnboardingViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        let img = UIImage(named: "onboarding\(indexPath.row+1)")!
        cell.pageControl.numberOfPages = titles.count
        cell.configureCell(title: titles[indexPath.row], description: descriptions[indexPath.row], image: img, index: indexPath.row)
        cell.callNext = {
            self.moveForward()
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}


extension OnboardingViewController:UIGestureRecognizerDelegate{
    
}
