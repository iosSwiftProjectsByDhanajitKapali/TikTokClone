//
//  StringExtension.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 24/05/22.
//

import Foundation

extension String {
    
    static func date(with date : Date) -> String {
        return DateFormatter.defaultFormatter.string(from: date)
    }
}
