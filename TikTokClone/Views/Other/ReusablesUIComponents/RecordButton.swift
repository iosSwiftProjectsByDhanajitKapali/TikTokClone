//
//  RecordButton.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 01/06/22.
//

import UIKit

class RecordButton : UIButton {
    
    override init(frame : CGRect){
        super.init(frame: frame)
        backgroundColor = nil
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
    }
    
    required init?(coder : NSCoder){
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = height/2
    }
    
    enum RecordButtonState{
        case recording
        case notRecording
    }
    public func toggle(for state : RecordButtonState) {
        switch state {
        case .recording:
            backgroundColor = .systemRed
        case .notRecording:
            backgroundColor = nil
        }
    }
}
