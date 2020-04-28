//
//  ViewController.swift
//  onboarding-travel-app
//
//  Created by trungnghia on 4/27/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit


class OnboardingViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    //MARK: - Vars and Consts
    let items: [OnboardingItem] = OnboardingItem.placeholderItems
    private var currentPage: Int = 0
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
        setupScreen(index: currentPage)
        setupBackgroundImage(index: currentPage)
        setupGestures()
        setupView()
        print("run viewDidLoad()")
    }
    
    
    //MARK: - Setup page funcs
    private func setupView() {
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
    }
    
    private func setupBackgroundImage(index: Int) {
        let image = items[index].bgImage
        
        UIView.transition(with: bgImageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {self.bgImageView.image = image},
                          completion: nil)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setupScreen(index: Int) {
        titleLabel.text = items[index].title
        detailLabel.text = items[index].detail
        pageControl.currentPage = index
        self.titleLabel.alpha = 1.0
        self.detailLabel.alpha = 1.0
        self.titleLabel.transform = .identity
        self.detailLabel.transform = .identity
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAninamtion))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapAninamtion() {
        // First animation - title label
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: -30, y: -550)
            }, completion: nil)
        }
        
        // Second animation - detail label, background image
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.detailLabel.alpha = 0.8
            self.detailLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.detailLabel.alpha = 0
                self.detailLabel.transform = CGAffineTransform(translationX: -30, y: -550)
                if self.currentPage < self.items.count - 1 {
                     self.setupBackgroundImage(index: self.currentPage + 1)
                }
               
            }) { (_) in
                
                self.currentPage += 1
                
                if self.isOverLastItem() {
                    // Show the main part of the app
                    self.showMainAppView()
                } else {
                    self.setupScreen(index: self.currentPage)
                }
            }
        }
    }
    
    private func isOverLastItem() -> Bool {
        return currentPage == items.count
    }
    
    //MARK: - Navigation
    private func showMainAppView() {
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "mainAppView")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = mainView
            UIView.transition(with: window,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
            
        
    }

}

