//
//  ExploreSectionType.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 24/05/22.
//

import Foundation

enum ExploreSectionType : CaseIterable{
    case banners
    case trendingPosts
    case trendingHashtags
    case users
    case recommended
    case popular
    case new
    
    var title : String {
        switch self {
        case .banners:
            return "Featured"
        case .trendingPosts:
            return "Trending"
        case .trendingHashtags:
            return "HashTags"
        case .users:
            return "Popular Creators"
        case .recommended:
            return "Recommended"
        case .popular:
            return "Popular"
        case .new:
            return "Recently Posted"
        }
    }
}
