//
//  AchievementType.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

/// Object represents the Section 
class AchievementType {
    
    // MARK:- Properties
    let id = UUID()
    let name: String
    let achievements: [Achievement]
    
    
    // MARK:- init
    init(name: String, achievements: [Achievement]) {
        self.name = name
        self.achievements = achievements
    }
}

extension AchievementType: Hashable {
    static func == (lhs: AchievementType, rhs: AchievementType) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}
