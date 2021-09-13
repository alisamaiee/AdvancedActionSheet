//
//  AdcancedActionSheetNormalCell.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 5/21/19.
//  Copyright © 2021 Ali Samaiee. All rights reserved.
//

import UIKit

internal class AdcancedActionSheetNormalCell: UITableViewCell {
    
    var actionID: Int?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.asText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.titleFont
        
        return label
    }()
    
    let bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.asAlertDivider
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomLine)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot init with coder")
    }
    
    func setupViews() {
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 6).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -6).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func update(title: String, actionID: Int) {
        self.actionID = actionID
        self.titleLabel.text = title
    }
    
    func setTitleAlpha(a: CGFloat) {
        self.titleLabel.alpha = a
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
