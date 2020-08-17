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
    
    // MARK:- Layout Objects
    let achievementLogoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "work"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let achievementNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.CustomFonts.semiBold15
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let achievementDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.CustomFonts.regular18
        label.textAlignment = .center
        return label
    }()
    
    lazy var overallStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [achievementLogoImageView,
                                                achievementNameLabel,
                                                achievementDurationLabel,
                                                UIView(),])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 4
        sv.axis = .vertical
        achievementLogoImageView.heightAnchor.constraint(equalTo: sv.heightAnchor, multiplier: 0.6).isActive = true
        return sv
    }()
    
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
        addSubview(overallStackView)
        NSLayoutConstraint.activate([
            overallStackView.topAnchor.constraint(equalTo: topAnchor),
            overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configureCell(with achievement: Achievement?) {
        achievementNameLabel.text = achievement?.name
        achievementDurationLabel.text = achievement?.distance
        achievementLogoImageView.image = UIImage(named: achievement!.image)
    }
    
}
