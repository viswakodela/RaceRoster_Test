//
//  AchievementsAsyncOperation.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

/// Use this Operation class to mock the API Network operations.
/// Note: - We need to be careful when modifying this class, we have to make sure we are setting the `state` to `isFinished`, otherwise the completionBlock for this operation won't get called.
class AchievementsAsyncOperation: AsyncOperation {
    
    // MARK:- Properties
    private let achievementsQueue   = DispatchQueue(label: "com.achievements.ca",
                                                  qos: .userInitiated,
                                                  attributes: .concurrent)
    
    var achievementSections = [AchievementType]()
    
    private var block: (AchievementsAsyncOperation) -> Void
    
    init(_ block: @escaping (AchievementsAsyncOperation) -> Void) {
        self.block = block
    }
    
    override func main() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        fetchAchievements()
    }
    
    private func fetchAchievements() {
        achievementsQueue.async {
            // mocking the UI by asking the system to sleep for 2 secons
            sleep(2)
            let personalAchievements = [Achievement(name: "Longest Run", image: "\(Int.getRandomNum)", distance: "00:00"),
                                        Achievement(name: "Highest Elevation", image: "\(Int.getRandomNum)", distance: "2095 ft"),
                                        Achievement(name: "Fastest 5K", image: "\(Int.getRandomNum)", distance: "00:00"),
                                        Achievement(name: "10K", image: "\(Int.getRandomNum)", distance: "00:00:00"),
                                        Achievement(name: "Half Marathon", image: "\(Int.getRandomNum)", distance: "00:00"),
                                        Achievement(name: "Marathon", image: "\(Int.getRandomNum)", distance: "Not Yet", isAchieved: false),]
            
            let personalSection = AchievementType(name: "Personal Record", achievements: personalAchievements)
            self.achievementSections.append(personalSection)
            
            let virutalAchievements = [Achievement(name: "Virtual Half Marathon Race", image: "\(Int.getRandomNum)", distance: "00:00"),
                                       Achievement(name: "Tokyo-Hakone Ekiden 2020", image: "\(Int.getRandomNum)", distance: "00:00:00"),
                                       Achievement(name: "Virtual 10K Race", image: "\(Int.getRandomNum)", distance: "00:00:000"),
                                       Achievement(name: "Hakone Ekiden", image: "\(Int.getRandomNum)", distance: "00:00:00"),
                                       Achievement(name: "Mizuno Singapore Ekiden 2015", image: "\(Int.getRandomNum)", distance: "00:00:00"),
                                       Achievement(name: "Virtual 5K Race", image: "\(Int.getRandomNum)", distance: "23:07"),]
            
            let virtialRaceSection = AchievementType(name: "Virtual Races", achievements: virutalAchievements)
            self.achievementSections.append(virtialRaceSection)
            
            self.block(self)
            self.state = .isFinished
        }
    }
}
