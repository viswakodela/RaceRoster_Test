//
//  AchievementsViewController.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class AchievementsViewController: UIViewController {
    
    // MARK:- init
    
    // MARK:- Layout Objects
    private let loadingSpinner          = LoadingViewController(isVerticalAligned: true)
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchAchievements()
    }
}

// MARK:- Helpers
private extension AchievementsViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func fetchAchievements() {
        add(loadingSpinner)
        
        let operation = AchievementsAsyncOperation()
        let queue = AppDelegate.giveMeNewOperation(withName: "com.raceroster.achievements.oq")
        operation.completionBlock = {
            DispatchQueue.main.async {
                self.loadingSpinner.remove()
                self.view.backgroundColor = .red
            }
        }
        queue.addOperation(operation)
    }
}

