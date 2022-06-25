//
//  Notifications.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 02/06/22.
//

import Foundation

enum NotificationModelType {
    case postLike(postname : String)
    case userFollow(username : String)
    case postComment(postname : String)
    
    var id : String {
        switch self {
        case .postLike:
            return "postLike"
        case .userFollow:
            return "userFollow"
        case .postComment:
            return "postComment"
        }
    }
}

struct NotificationModel {
    var isHidden = false
    let text : String
    let type : NotificationModelType
    let date : Date
    
    init(text : String, type : NotificationModelType, date : Date) {
        self.text = text
        self.type = type
        self.date = date
    }
    
    static func mockData() -> [NotificationModel] {
        let first = Array(0...3).compactMap({
            NotificationModel(
                text: "You can follow User\($0)",
                type: .userFollow(username: "charlie"),
                date: Date()
            )
        })
        
        let second = Array(0...2).compactMap({
            NotificationModel(
                text: " Someone liked your wonderful post: \($0)",
                type: .postLike(postname: "Post like, dhanajei jabfr liekd uotu imahe"),
                date: Date()
            )
        })
        
        let third = Array(0...5).compactMap({
            NotificationModel(
                text: "Someone commented on your post,: \($0)",
                type: .postComment(postname: "what a wonderful pait, nbai maxha a ya"),
                date: Date()
            )
        })
        
        return first + second + third
    }
}
