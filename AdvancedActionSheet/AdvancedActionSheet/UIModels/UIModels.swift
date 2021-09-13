//
//  UIModels.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 9/13/21.
//

import Foundation
import UIKit
import Photos

public enum CustomAlertCellItem {
    /**
     completionHandler:
     - media assets
     - selected action IDs (from selectable actions)
     - send as file?
     */
    case quickGalleryCollectionView(showCamera: Bool, completionHandler: (_ assets: [PHAsset], _ selectedActionIDs: [Int], _ sendAsFile: Bool) -> Void, _ openCameraCallback: () -> Void)
    
    /// - deactivatable: Will deactive button if no item is selected (No need to set it if you are not using selectable actions)
    case normal(id: Int, title: String, deactivatable: Bool = false, completionHandler: ([Int]) -> ())
    case selectable(item: SelectableActionItem)
    case actionWithIcon(title: String, titleColor: UIColor? = nil, image: UIImage, completionHandler: ([Int]) -> ())
}

public struct SelectableActionItem {
    
    struct Constants {
        static let defaultTickImageName = "ASTickIcon"
    }
    
    let id: Int
    let icon: UIImage
    let title: String
    let subtitle: String
    let defaultSelectionStatus: Bool
    /// Usually we don't need last cell to have bottom divider line
    let drawBottomLine: Bool
    
    /// icon is a tick image by default (when you pass nil), set non-nil image to change it
    public init(id: Int, icon: UIImage?, title: String, subtitle: String, defaultSelectionStatus: Bool, drawBottomLine: Bool) {
        self.id = id
        self.icon = icon ?? ImageUtility.getImage(named: Constants.defaultTickImageName) ?? UIImage()
        self.title = title
        self.subtitle = subtitle
        self.defaultSelectionStatus = defaultSelectionStatus
        self.drawBottomLine = drawBottomLine
    }
}
