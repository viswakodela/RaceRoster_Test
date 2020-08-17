//
//  AchievementsViewController.swift
//  RaceRoster_Test
//
//  Created by Viswa Kodela on 2020-08-17.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class AchievementsViewController: UIViewController {
    
    // MARK:- Properties
    private var achievementSections     = [AchievementType]()
    private lazy var dataSource         = createDataSource()
    
    // MARK:- Layout Objects
    private let loadingSpinner          = LoadingViewController(isVerticalAligned: true)
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.alwaysBounceVertical = true
        cv.showsVerticalScrollIndicator = false
        cv.register(AchievementCell.self, forCellWithReuseIdentifier: AchievementCell.cellId)
        cv.register(AchievementHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AchievementHeader.headerId)
        return cv
    }()
    
    typealias DataSource                = UICollectionViewDiffableDataSource<AchievementType, Achievement>
    typealias Snapshot                  = NSDiffableDataSourceSnapshot<AchievementType, Achievement>
    
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
        navigationItem.title = "Achievements"
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(0.5),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2)
        
        let headerSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: AchievementHeader.headerId,
            alignment: .top)
        //sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func fetchAchievements() {
        add(loadingSpinner)
        
        let operation = AchievementsAsyncOperation { [weak self] (operation) in
            guard let self = self else { return }
            self.achievementSections = operation.achievementSections
        }
        let queue = AppDelegate.giveMeNewOperation(withName: "com.raceroster.achievements.oq")
        operation.completionBlock = {
            DispatchQueue.main.async {
                self.loadingSpinner.remove()
                self.applySnapshot()
            }
        }
        queue.addOperation(operation)
    }
    
    func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, achievement) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AchievementCell.cellId, for: indexPath) as? AchievementCell
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AchievementHeader.headerId, for: indexPath) as! AchievementHeader
            header.headerLabel.text = self.achievementSections[indexPath.section].name
            return header
        }
        
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(achievementSections)
        for section in achievementSections {
            snapshot.appendItems(section.achievements, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

