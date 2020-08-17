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
            sleep(2)
            let personalAchievements = [Achievement(name: "Longest Run", image: nil, distance: "00:00"),
                                        Achievement(name: "Highest Elevation", image: nil, distance: "2095 ft"),
                                        Achievement(name: "Fastest 5K", image: nil, distance: "00:00"),
                                        Achievement(name: "10K", image: nil, distance: "00:00:00"),
                                        Achievement(name: "Half Marathon", image: nil, distance: "00:00"),
                                        Achievement(name: "Marathon", image: nil, distance: "Not Yet", isAchieved: false),]
            
            let personalSection = AchievementType(name: "Personal Record", achievements: personalAchievements)
            self.achievementSections.append(personalSection)
            
            let virutalAchievements = [Achievement(name: "Virtual Half Marathon Race", image: nil, distance: "00:00"),
                                       Achievement(name: "Tokyo-Hakone Ekiden 2020", image: nil, distance: "00:00:00"),
                                       Achievement(name: "Virtual 10K Race", image: nil, distance: "00:00:000"),
                                       Achievement(name: "Hakone Ekiden", image: nil, distance: "00:00:00"),
                                       Achievement(name: "Mizuno Singapore Ekiden 2015", image: nil, distance: "00:00:00"),
                                       Achievement(name: "Virtual 5K Race", image: nil, distance: "23:07"),]
            
            let virtialRaceSection = AchievementType(name: "Virtual Races", achievements: virutalAchievements)
            self.achievementSections.append(virtialRaceSection)
            
            self.block(self)
            self.state = .isFinished
        }
    }
}
