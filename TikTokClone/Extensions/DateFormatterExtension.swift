//
//  DateFormatterExtension.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 24/05/22.
//

import Foundation

extension DateFormatter {
    
    static let defaultFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
