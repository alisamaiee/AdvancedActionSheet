//
//  CameraCollectionViewCell.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 4/7/20.
//  Copyright © 2020 Ronak Software. All rights reserved.
//

import Foundation
import UIKit

class CameraCollectionViewCell: UICollectionViewCell {
    
    private struct Constants {
        static let cameraImageName = "ASCameraIcon"
    }
    
    let cameraView: CameraView = {
        let view = CameraView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let cameraImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.image = ImageUtility.getImage(named: Constants.cameraImageName)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
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
        
        contentView.addSubview(cameraView)
        contentView.addSubview(cameraImageView)
        
        cameraImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35).isActive = true
        cameraImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        cameraImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cameraImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        cameraView.frame = contentView.frame
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }
}
