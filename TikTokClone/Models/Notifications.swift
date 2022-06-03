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
        let first = Array(0...5).compactMap({
            NotificationModel(
                text: "Something happened: \($0)",
                type: .userFollow(username: "charlie"),
                date: Date()
            )
        })
        
        let second = Array(0...5).compactMap({
            NotificationModel(
                text: " Someone liked your wonderful post, sdadasdasdasd: \($0)",
                type: .postLike(postname: "Post like, dhanajei jabfr liekd uotu imahe"),
                date: Date()
            )
        })
        
        let third = Array(0...5).compactMap({
            NotificationModel(
                text: "Someone commented on your post, ncjndjsjncdjncjdcnjdnc: \($0)",
                type: .postComment(postname: "what a wonderful pait, nbai maxha a ya"),
                date: Date()
            )
        })
        
        return first + second + third
    }
}
