//
//  AdcancedActionSheetComplexCell.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 5/21/19.
//  Copyright © 2021 Ali Samaiee. All rights reserved.
//

import UIKit

internal class AdcancedActionSheetComplexCell: UITableViewCell {
    
    var actionID: Int?
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isOpaque = true
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.asText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.titleFont

        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.asText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.subtitleFont
        
        return label
    }()
    
    private let bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.asAlertDivider
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(bottomLine)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot init with coder")
    }
    
    func setupViews() {
        
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
                
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 6).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        
        subtitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 6).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        subtitleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        
        bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func update(title: String, subtitle: String, image: UIImage, imageTint: UIColor? = nil, actionID: Int, drawBottomLine: Bool) {
        self.actionID = actionID
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.iconImageView.image = image
        self.iconImageView.tintColor = tintColor
        self.bottomLine.isHidden = !drawBottomLine
        if let strongImageTint = imageTint {
            self.iconImageView.tintColor = strongImageTint
        }
    }

    func setImageViewVisibility(_ visible: Bool) {
        self.iconImageView.isHidden = !visible
    }
}
