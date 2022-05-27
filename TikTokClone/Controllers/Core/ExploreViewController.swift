//
//  ExploreViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class ExploreViewController: UIViewController {

    // MARK: - Private Data Members
    private var sections = [ExploreSection]()
    
    // MARK: - UI Components
    private let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search..."
        bar.layer.cornerRadius = 8
        bar.layer.masksToBounds = true
        return bar
    }()
    
    private var collectionView : UICollectionView?

}


// MARK: - LifeCycle Methods
extension ExploreViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModels()
        setUpSearchBar()
        setUpCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView?.frame = view.bounds
    }
}


// MARK: - Private Methods
private extension ExploreViewController {
    
    func configureModels() {
        //Mocking ExploreSection cells
        var banners = [ExploreCell]()
        for x in 0...100 {
            let cell = ExploreCell.banner(
                viewModel: ExploreBannerViewModel(
                    image: UIImage(named: "sampleImage1"),
                    title: "Foo",
                    handler: {
                        
                    }
                )
            )
            banners.append(cell)
        }
        
        //Banner
        sections.append(
            ExploreSection(
                type: .banners,
                cells: banners
            )
        )
//        let temp = ExploreManager.shared.getExploreBanners()
//        sections.append(
//            ExploreSection(
//                type: .banners,
//                cells: temp.compactMap({
//                    return ExploreCell.banner(viewModel: $0)
//                })
//            )
//        )
        
        
        var posts = [ExploreCell]()
        for _ in 0...40 {
            posts.append(
                ExploreCell.post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "sampleImage"), caption: "This is an awesome Post and a long caption", handler: {
                    
                }))
            )
        }
        //Trending Posts
        sections.append(ExploreSection(type: .trendingPosts, cells: posts ))
        
        //Users
        var users = [ExploreCell]()
        for _ in 0...40 {
            users.append(ExploreCell.user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "Kayne west the great personality", followerCount: 20, handler: {
                
            }))
            )
        }
        sections.append(ExploreSection(type: .users, cells: users))
        
        //Trending HashTags
        sections.append(ExploreSection(type: .trendingHashtags, cells: [
            .hashtag(viewModel: ExploreHashtagViewModel(text: "#forYou", icon: UIImage(systemName: "bell"), count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "#forYou", icon: UIImage(systemName: "bell"), count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "#forYou", icon: UIImage(systemName: "bell"), count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "#forYou", icon: UIImage(systemName: "bell"), count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "#forYou", icon: UIImage(systemName: "bell"), count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "#forYou", icon: UIImage(systemName: "bell"), count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "#forYou", icon: UIImage(systemName: "bell"), count: 0, handler: {
            }))
        ]))
        
        //Recommended
        sections.append(ExploreSection(type: .recommended, cells: posts))
        
        //Popular
        sections.append(ExploreSection(type: .popular, cells: posts))
        
        //New/Recent
        sections.append(ExploreSection(type: .new, cells: posts))
    }
    
    func setUpSearchBar(){
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func setUpCollectionView(){
        let layout = UICollectionViewCompositionalLayout{
             section, _ -> NSCollectionLayoutSection? in
            return self.layout(for : section)
        }
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        collectionView.register(
            ExploreBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier
        )
        collectionView.register(
            ExplorePostCollectionViewCell.self,
            forCellWithReuseIdentifier: ExplorePostCollectionViewCell.identifier
        )
        collectionView.register(
            ExploreUserCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier
        )
        collectionView.register(
            ExploreHashtagCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreHashtagCollectionViewCell.identifier
        )
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func layout(for section : Int) -> NSCollectionLayoutSection {
        let sectionType = sections[section].type
        
        switch sectionType {
        case .banners:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            return sectionLayout
            
            
        case .trendingHashtags:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(120)
                ),
                subitem: item,
                count: 2
            )
            
            
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: verticalGroup)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            return sectionLayout
            
            
        case .users:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(160),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            return sectionLayout
            
            
        case .trendingPosts, .recommended, .new:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(300)
                ),
                subitem: item,
                count: 2
            )
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(300)
                ),
                subitems: [verticalGroup]
            )
            
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            return sectionLayout
        
        case .popular :
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            //Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            return sectionLayout
            
        }
        
        
    }
}

    
// MARK: - UICollectionViewDataSource Methods
extension ExploreViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
        case .banner(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExploreBannerCollectionViewCell.identifier,
                for: indexPath
            ) as? ExploreBannerCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }
            cell.configure(with: viewModel)
            return cell
            
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExplorePostCollectionViewCell.identifier,
                for: indexPath
            ) as? ExplorePostCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }
            cell.configure(with: viewModel)
            return cell
            
        case .hashtag( let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExploreHashtagCollectionViewCell.identifier,
                for: indexPath
            ) as? ExploreHashtagCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }
            cell.configure(with: viewModel)
            return cell
            
        case .user(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExploreUserCollectionViewCell.identifier,
                for: indexPath
            ) as? ExploreUserCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }
            cell.configure(with: viewModel)
            return cell
        }
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .red
//        return cell
    }
    
}


// MARK: - UICollectionViewDelegate Methods
extension ExploreViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
            
        case .banner(viewModel: let viewModel):
            break
        case .post(viewModel: let viewModel):
            break
        case .hashtag(viewModel: let viewModel):
            break
        case .user(viewModel: let viewModel):
            break
        }
    }
}


// MARK: - UISearchBarDelegate Methods
extension ExploreViewController : UISearchBarDelegate{
    
}
