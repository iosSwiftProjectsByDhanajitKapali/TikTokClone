//
//  SaveVideoSwitchTableViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 09/06/22.
//

import UIKit

struct SwitchCellViewModel {
    let title : String
    var isOn : Bool
    
    mutating func setOn(_ on : Bool) {
        self.isOn = on
    }
}

protocol SaveVideoSwitchTableViewCellDelegate : AnyObject {
    func saveVideoSwitchTableViewCell(_ cell : SaveVideoSwitchTableViewCell, didUpdateSwitch isOn : Bool)
}

class SaveVideoSwitchTableViewCell: UITableViewCell {

    static let identifier = "SaveVideoSwitchTableViewCell"
    
    weak var delegate : SaveVideoSwitchTableViewCellDelegate?
    
    // MARK: - UI Components
    private let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let _switch : UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = .systemBlue
        _switch.isOn = UserDefaults.standard.bool(forKey: "save_video")
        return _switch
    }()
    
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        selectionStyle = .none
        
        contentView.addSubview(label)
        contentView.addSubview(_switch)
        _switch.addTarget(self, action: #selector(didChangedSwitchValue(_:)), for: .valueChanged)
    }
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 10, width: label.width, height: label.height)
        
        _switch.sizeToFit()
        _switch.frame = CGRect(
            x: contentView.width - _switch.width - 10,
            y: 5,
            width: _switch.width,
            height: _switch.height
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    @objc func didChangedSwitchValue(_ sender : UISwitch) {
        delegate?.saveVideoSwitchTableViewCell(self, didUpdateSwitch: sender.isOn)
    }
    
    func configure(with viewModel : SwitchCellViewModel){
        label.text = viewModel.title
        _switch.isOn = viewModel.isOn
    }
}
