//
//  Int+Extension.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

extension Int {
    static var getRandomNum: Int {
        Int.random(in: 0..<50)
    }
}
