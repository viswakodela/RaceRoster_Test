//
//  AchievementsAsyncOperation.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class AchievementsAsyncOperation: AsyncOperation {
    
    // MARK:- Properties
    private let achievementsQueue   = DispatchQueue(label: "com.achievements.ca",
                                                  qos: .userInitiated,
                                                  attributes: .concurrent)

    let achievements: [String]       = []
    
    override func main() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        fetchAchievements()
    }
    
    private func fetchAchievements() {
        achievementsQueue.async {
            sleep(4)
            self.state = .isFinished
        }
    }
}
