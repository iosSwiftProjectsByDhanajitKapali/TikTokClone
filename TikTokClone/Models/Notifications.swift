//
//  Notifications.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 02/06/22.
//

import Foundation

struct NotificationModel {
    let text : String
    let date : Date
    
    static func mockData() -> [NotificationModel] {
        return Array(0...100).compactMap({
            NotificationModel(text: "Something happened: \($0)", date: Date())
        })
    }
}
