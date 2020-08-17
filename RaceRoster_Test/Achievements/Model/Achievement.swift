//
//  Achievement.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

class Achievement {
    
    // MARK:- Properties
    let name: String
    let image: String
    let distance: String
    let isAchieved: Bool
    let id = UUID()
    
    // MARK:- init
    init(name: String, image: String, distance: String, isAchieved: Bool = true) {
        self.name = name
        self.image = image
        self.distance = distance
        self.isAchieved = isAchieved
    }
}

extension Achievement: Hashable {
    static func == (lhs: Achievement, rhs: Achievement) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}
