//
//  PostModel.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 23/05/22.
//

import Foundation

struct PostModel{
    let identifier : String
    let user : User
    
    var fileName : String = ""
    var caption : String = ""
    var isLikedByCurrentUser = false
    
    var videoChildPath : String {
        return "videos/\(user.userName.lowercased())/\(fileName)"
    }
    
    static func mockModels() -> [PostModel] {
        let posts = Array(0...100).compactMap({_ in
            PostModel(
                identifier: UUID().uuidString,
                user : User(userName: "kanyewest", profilePictureURL: nil, identifier: UUID().uuidString)
            )
        })
        return posts
    }
}
