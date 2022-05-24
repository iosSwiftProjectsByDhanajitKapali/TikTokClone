//
//  ExploreCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 24/05/22.
//

import UIKit

enum ExploreCell {
    case banner(viewModel : ExploreBannerViewModel)
    case post(viewModel : ExplorePostViewModel)
    case hashtag(viewModel : ExploreHashtagViewModel)
    case user(viewModel : ExploreUserViewModel)
}

struct ExploreBannerViewModel {
    let image : UIImage?
    let title : String
    let handler : (() -> Void)
}

struct ExplorePostViewModel {
    let thumbnailImage : UIImage?
    let caption : String
    let handler : (() -> Void)
}

struct ExploreHashtagViewModel {
    let text : String
    let icon : UIImage?
    let count : Int //no of post associated with this HashTag
    let handler : (() -> Void)
}

struct ExploreUserViewModel {
    let profilePictureURL : URL?
    let userName : String
    let followerCount : Int
    let handler : (() -> Void)
}


