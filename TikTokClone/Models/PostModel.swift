//
//  PostModel.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 23/05/22.
//

import Foundation

struct PostModel{
    let identifier : String
    
    let user = User(userName: "kanyewest", profilePictureURL: nil, identifier: UUID().uuidString)
    
    var isLikedByCurrentUser = false
    
    static func mockModels() -> [PostModel] {
        let posts = Array(0...100).compactMap({_ in
            PostModel(identifier: UUID().uuidString)
        })
        return posts
    }
}
