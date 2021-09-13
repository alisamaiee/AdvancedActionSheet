//
//  AdcancedActionSheetActionWithImageCell.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 7/8/19.
//  Copyright © 2021 Ali Samaiee. All rights reserved.
//

import Foundation
import UIKit

internal class AdcancedActionSheetActionWithImageCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
        contentView.addSubview(iconImageView)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot init with coder")
    }
    
    func setupViews() {
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -6).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func update(title: String, titleColor: UIColor?, image: UIImage) {
        self.titleLabel.text = title
        self.titleLabel.textColor = (titleColor == nil) ? UIColor.asText : titleColor
        self.iconImageView.image = image
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
