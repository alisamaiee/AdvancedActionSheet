//
//  QuickGalleryCollectionViewCell.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 11/11/19.
//  Copyright © 2021 Ali Samaiee. All rights reserved.
//

import UIKit

class QuickGalleryCollectionViewCell: UICollectionViewCell {
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.isHidden = true
        label.isUserInteractionEnabled = false
        label.textAlignment = .right
        label.contentMode = .bottomRight
        label.font = UIFont.videoDurationFont
        
        return label
    }()
    
    let checkBox: RoundCheckBox = {
        let checkBox = RoundCheckBox()
        checkBox.isOpaque = true
        checkBox.backgroundColor = .clear
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.bgColorSelected = UIColor.asRoundChecboxChekced
        checkBox.line = .normal
        checkBox.color = .white
        checkBox.layer.borderWidth = 2
        checkBox.layer.borderColor = UIColor.asCheckBoxBorder.cgColor
        checkBox.cornerRadius = 13
        checkBox.layer.masksToBounds = true
        checkBox.isAnimateEnabled = false
        checkBox.isUserInteractionEnabled = false
        
        return checkBox
    }()
    
    lazy var imageView: UIImageView = {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public func setup() {
        backgroundColor = .clear
        
        contentView.addSubview(imageView)
        contentView.addSubview(self.checkBox)
        contentView.addSubview(self.durationLabel)
        
        checkBox.widthAnchor.constraint(equalToConstant: 26).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 26).isActive = true
        checkBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6).isActive = true
        checkBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        
        durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6).isActive = true
        durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.frame
        imageView.layer.cornerRadius = 10
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }
    
    func updateLabel(text: String) {
        self.durationLabel.isHidden = text.isEmpty
        self.durationLabel.text = text
    }
}

