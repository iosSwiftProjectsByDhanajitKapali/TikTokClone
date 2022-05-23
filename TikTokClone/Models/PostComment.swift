//
//  PostComment.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 24/05/22.
//

import Foundation

struct PostComment {
    let text : String
    let user : User
    let date : Date
    
    static func mockComments() -> [PostComment] {
        let user = User(userName: "kaynewest", profilePictureURL: nil, identifier: UUID().uuidString)
        var comments = [PostComment]()
        
        let commentsText = [
            "This is so Cool",
            "This is rad",
            "Im learning so much",
        ]
        
        for text in commentsText{
            comments.append(PostComment(text: text, user: user, date: Date()))
        }
        
        return comments
    }
}
