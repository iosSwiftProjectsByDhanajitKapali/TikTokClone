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
    let text : String
    let type : NotificationModelType
    let date : Date
    
    static func mockData() -> [NotificationModel] {
        return Array(0...100).compactMap({
            NotificationModel(
                text: "Something happened: \($0)",
                type: .userFollow(username: "charlie"),
                date: Date()
            )
        })
    }
}
