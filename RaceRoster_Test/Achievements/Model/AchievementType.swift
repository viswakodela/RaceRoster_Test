//
//  AchievementType.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

class AchievementType {
    
    // MARK:- Properties
    let name: String
    let achievements: [Achievement]
    
    
    // MARK:- init
    init(name: String, achievements: [Achievement]) {
        self.name = name
        self.achievements = achievements
    }
}
