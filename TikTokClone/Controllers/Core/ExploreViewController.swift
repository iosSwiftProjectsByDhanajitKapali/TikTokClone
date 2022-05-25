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
        var cells = [ExploreCell]()
        for x in 0...100 {
            let cell = ExploreCell.banner(
                viewModel: ExploreBannerViewModel(
                    image: nil,
                    title: "Foo",
                    handler: {
                        
                    }
                )
            )
            cells.append(cell)
        }
        
        //Banner
        sections.append(
            ExploreSection(
                type: .banners,
                cells: cells
            )
        )
        
        //Trending Posts
        sections.append(ExploreSection(type: .trendingPosts, cells: [
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            }))
        ]))
        
        //Users
        sections.append(ExploreSection(type: .users, cells: [
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            })),
            .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, userName: "", followerCount: 0, handler: {
            }))
        ]))
        
        //Trending HashTags
        sections.append(ExploreSection(type: .trendingHashtags, cells: [
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            })),
            .hashtag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
            }))
        ]))
        
        //Recommended
        sections.append(ExploreSection(type: .recommended, cells: [
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            }))
        ]))
        
        //Popular
        sections.append(ExploreSection(type: .popular, cells: [
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            }))
        ]))
        
        //New/Recent
        sections.append(ExploreSection(type: .new, cells: [
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            })),
            .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
            }))
        ]))
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
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
                    widthDimension: .absolute(200),
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
                    heightDimension: .absolute(240)
                ),
                subitem: item,
                count: 2
            )
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(240)
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

    
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource Methods
extension ExploreViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
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
            break
        case .post(let viewModel):
            break
        case .hashtag( let viewModel):
            break
        case .user(let viewModel):
            break
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
}


// MARK: - UISearchBarDelegate Methods
extension ExploreViewController : UISearchBarDelegate{
    
}
