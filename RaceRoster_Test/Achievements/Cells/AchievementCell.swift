//
//  AchievementCell.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class AchievementCell: UICollectionViewCell {
    
    // MARK:- Properties
    static let cellId       = String(describing: type(of: self))
    
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Helpers
    private func configureLayout() {
        backgroundColor = .black
    }
    
}
