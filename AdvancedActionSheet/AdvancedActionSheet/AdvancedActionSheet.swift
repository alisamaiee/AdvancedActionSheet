//
//  AdvancedActionSheet.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 5/21/19.
//  Copyright © 2021 Ali Samaiee. All rights reserved.
//

import Foundation
import Photos
import UIKit

public class AdvancedActionSheet: UIViewController {
    
    private struct Constants {
        static let itemHeight: CGFloat = 57.5
        static var quickGalleryHeight: CGFloat = (UIScreen.main.bounds.width / 5) + 16
        static let sendButtonIdConst = 100
    }
    
    private var selectedAssetsOfQuickGallery = [PHAsset]()
    
    /// parent view to handle animation and transitions of children
    private var mainView = UIView()
    private var contentView = UIView()
    private var cancelView = UIView()
    private var cancelLabel = UILabel()
    private var contentTableView: UITableView!
    private var contentViewHeightAnchor: NSLayoutConstraint!
    private var mainViewAnchorConstraint: NSLayoutConstraint!
    private var actionItems = [CustomAlertCellItem]()
    private var tempPrimeryActions = [CustomAlertCellItem]()
    private var tempSecondaryActionsForQuickGallery = [CustomAlertCellItem]()
    private var selectedItemIDs = [Int]()
    private var deactivatableButtonIDs = [Int]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.postInit()
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationInBackground(notification:)),
                                               name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc func applicationInBackground(notification: NSNotification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.postInit()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTableView = UITableView()
        self.registerCells()
        self.contentTableView.separatorStyle = .none
        self.contentTableView?.delegate = self
        self.contentTableView?.dataSource = self
        self.contentTableView.backgroundColor = .clear
        self.setupViews()
    }
        
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainViewAnchorConstraint.isActive = false
        self.mainViewAnchorConstraint = mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        mainViewAnchorConstraint.isActive = true
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.view.layoutIfNeeded()
        }
        self.view.alpha = 1
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.clear
        super.viewWillDisappear(animated)
    }
    
    private func postInit() {
        self.modalPresentationStyle = .overFullScreen
        self.view.alpha = 0
        let dismissGesture = UITapGestureRecognizer(target: self, action:(#selector(self.dismissGestureAction)))
        self.mainView.addGestureRecognizer(dismissGesture)
        
        let cancelButtonGesture = UITapGestureRecognizer(target: self, action:(#selector(self.cancelButtonAction)))
        self.cancelLabel.addGestureRecognizer(cancelButtonGesture)
        self.cancelView.addGestureRecognizer(cancelButtonGesture)
        
        cancelView.backgroundColor = UIColor.asAlertBackground
        cancelView.layer.cornerRadius = 14
        cancelLabel.textAlignment = .center
        cancelLabel.textColor = UIColor.asText
        cancelLabel.font = UIFont.cancelFont
        cancelLabel.text = .cancel
        
        self.contentView.layer.cornerRadius = 14
        self.contentView.backgroundColor = UIColor.asAlertBackground
    }
    
    @objc func dismissGestureAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.contentTableView.visibleCells.forEach { (cell) in
            if let quickGalleryCell = cell as? QuickGalleryTableViewCell {
                quickGalleryCell.cleanupOnDismiss()
            }
        }
        super.dismiss(animated: true, completion: completion)
    }
    
    private func setupViews() {
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.cancelLabel.translatesAutoresizingMaskIntoConstraints = false
        self.cancelView.translatesAutoresizingMaskIntoConstraints = false
        self.contentTableView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainView)
        self.view.addSubview(contentView)
        self.view.addSubview(cancelView)
        self.view.addSubview(cancelLabel)
        self.view.addSubview(contentTableView)
        
        var bottomSpaceToCancelButton: CGFloat = -12
        if #available(iOS 11.0, *) {
            bottomSpaceToCancelButton = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 12) * -1
        }
        
        self.mainViewAnchorConstraint = mainView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        mainViewAnchorConstraint.isActive = true
        mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        
        cancelView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: 0).isActive = true
        cancelView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 0).isActive = true
        cancelView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: bottomSpaceToCancelButton).isActive = true
        cancelView.heightAnchor.constraint(equalToConstant: 57).isActive = true
        
        cancelLabel.trailingAnchor.constraint(equalTo: self.cancelView.trailingAnchor, constant: -6).isActive = true
        cancelLabel.leadingAnchor.constraint(equalTo: self.cancelView.leadingAnchor, constant: 6).isActive = true
        cancelLabel.bottomAnchor.constraint(equalTo: self.cancelView.bottomAnchor, constant: -16).isActive = true
        cancelLabel.topAnchor.constraint(equalTo: self.cancelView.topAnchor, constant: 16).isActive = true
        
        contentView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.cancelView.topAnchor, constant: -6).isActive = true
        self.contentViewHeightAnchor = contentView.heightAnchor.constraint(equalToConstant: 50)
        contentViewHeightAnchor.isActive = true
        
        contentTableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        contentTableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        contentTableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        contentTableView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
    }
    
    private func registerCells() {
        self.contentTableView.register(AdcancedActionSheetComplexCell.self as AnyClass, forCellReuseIdentifier: "customAlertComplexCell")
        self.contentTableView.register(AdcancedActionSheetNormalCell.self, forCellReuseIdentifier: "customAlertNormalCell")
        self.contentTableView.register(AdcancedActionSheetActionWithImageCell.self, forCellReuseIdentifier: "customAlertActionWithImageCell")
        self.contentTableView.register(QuickGalleryTableViewCell.self, forCellReuseIdentifier: "quickGalleryTableViewCell")
    }
    
    public func addAction(item: CustomAlertCellItem) {
        switch item {
        case .selectable(let selectableItem):
            self.tempPrimeryActions.append(item)
            self.actionItems.append(item)
            if selectableItem.defaultSelectionStatus {
                self.selectedItemIDs.append(selectableItem.id)
            }
        case .quickGalleryCollectionView(_, let handler, _):
            guard tempSecondaryActionsForQuickGallery.isEmpty else {
                fatalError("AdvancedActionSheet: ERROR - adding 2 or more quickGalleryCollectionView to action sheet is not allowed")
            }
            self.actionItems.insert(item, at: 0)
            
            let sendAction = CustomAlertCellItem.normal(id: Constants.sendButtonIdConst, title: .send, completionHandler: { [weak self] (_) in
                guard let self = self else { return }
                handler(self.selectedAssetsOfQuickGallery, self.selectedItemIDs, false)
            })
            
            let sendAsFileAction = CustomAlertCellItem.normal(id: 0, title: .sendAsFile, completionHandler: { [weak self] (_) in
                guard let self = self else { return }
                handler(self.selectedAssetsOfQuickGallery, self.selectedItemIDs, true)
            })
            
            self.tempSecondaryActionsForQuickGallery.append(sendAction)
            self.tempSecondaryActionsForQuickGallery.append(sendAsFileAction)
        case .normal(let id, _, let deactivatable, _):
            if deactivatable {
                self.deactivatableButtonIDs.append(id)
            }
            self.actionItems.append(item)
            self.tempPrimeryActions.append(item)
        default:
            self.actionItems.append(item)
            self.tempPrimeryActions.append(item)
        }
    }
    
    /**
     Use this method to present action sheet,
     OR you can present it in using UIViewController common present function, but remember to set animated parameter to false.
     Method must be called on main thread
     */
    public func present(presenter: UIViewController, completion: (() -> Void)?) {
        presenter.present(self, animated: false, completion: completion)
    }
    
    private func resetContentViewHeight(height: CGFloat) {
        self.contentViewHeightAnchor.isActive = false
        self.contentViewHeightAnchor = contentView.heightAnchor.constraint(equalToConstant: height)
        self.contentViewHeightAnchor.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func calculateContentHeight() -> CGFloat {
        var contentHeight: CGFloat = 0
        for item in self.actionItems {
            switch item {
            case .quickGalleryCollectionView(completionHandler: _):
                Constants.quickGalleryHeight = self.calculateQuickGalleryCellHeight()
                contentHeight += Constants.quickGalleryHeight
            default:
                contentHeight += Constants.itemHeight
                break
            }
        }
        return contentHeight
    }
    
    private func calculateQuickGalleryCellHeight() -> CGFloat {
        var height: CGFloat = (UIScreen.main.bounds.width / 5) + 16
        if self.selectedAssetsOfQuickGallery.count > 0 {
            let diffCount = CGFloat(self.tempPrimeryActions.count - self.tempSecondaryActionsForQuickGallery.count)
            height += (Constants.itemHeight * diffCount)
        }
        return (height > (UIScreen.main.bounds.width / 2)) ? (UIScreen.main.bounds.width / 2) : height
    }
    
    /// This func must be called if only you have quick media picker in table with one or more selected assets
    private func prepareTableForSendingMedias() {
        self.contentTableView.beginUpdates()
        var removedIndexPaths = [IndexPath]()
        for (index, item) in self.actionItems.enumerated() {
            switch item {
            case .normal(id: _, title: _, deactivatable: _, completionHandler: _), .actionWithIcon(title: _, titleColor: _, image: _, completionHandler: _), .selectable(item: _):
                removedIndexPaths.append(IndexPath(row: index, section: 0))
            default:
                break
            }
        }
        let removedIndexes = removedIndexPaths.map { $0.row }
        
        self.actionItems.remove(at: removedIndexes)
        self.contentTableView.deleteRows(at: removedIndexPaths, with: .fade)
        
        if self.tempSecondaryActionsForQuickGallery.count > 0 && actionItems.count > 0 {
            self.actionItems.append(self.tempSecondaryActionsForQuickGallery)
            var insertedIndexPaths = [IndexPath]()
            for index in 1...self.tempSecondaryActionsForQuickGallery.count {
                insertedIndexPaths.append(IndexPath(row: actionItems.count - index, section: 0))
            }
            self.contentTableView.insertRows(at: insertedIndexPaths, with: .fade)
        }
        self.contentTableView.endUpdates()
    }
    
    /// This func must be called if only you have  quick media picker in table with NO selected assets (When the user deselected all assets)
    private func prepareTableForNormalMode() {
        self.contentTableView.beginUpdates()
        var removedIndexPaths = [IndexPath]()
        for (index, item) in self.actionItems.enumerated() {
            switch item {
            case .normal(id: _, title: _, deactivatable: _, completionHandler: _), .actionWithIcon(title: _, titleColor: _, image: _, completionHandler: _), .selectable(item: _):
                removedIndexPaths.append(IndexPath(row: index, section: 0))
            default:
                break
            }
        }
        let removedIndexes = removedIndexPaths.map { $0.row }
        
        self.actionItems.remove(at: removedIndexes)
        self.contentTableView.deleteRows(at: removedIndexPaths, with: .fade)
        
        var insertedIndexPaths = [IndexPath]()
        for item in self.tempPrimeryActions {
            insertedIndexPaths.append(IndexPath(row: actionItems.count, section: 0))
            self.actionItems.append(item)
        }
        self.contentTableView.insertRows(at: insertedIndexPaths, with: .fade)
        self.contentTableView.endUpdates()
    }
}

extension AdvancedActionSheet: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let height  = self.calculateContentHeight()
        if (height > self.view.bounds.height * 0.7) {
            self.contentTableView.isScrollEnabled = true
            // Making cell half visible, so user will know there is more cells and can scroll
            let possibleNumberOfItemsWithoutScrolling = Int(self.view.bounds.height * 0.7 / Constants.itemHeight)
            let newHeight = (CGFloat(possibleNumberOfItemsWithoutScrolling) - 0.5) * Constants.itemHeight
            self.resetContentViewHeight(height: (newHeight > 0) ? newHeight : self.view.bounds.height * 0.7)
        } else {
            self.contentTableView.isScrollEnabled = false
            self.resetContentViewHeight(height: height)
        }
        return self.actionItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let strongItem = self.actionItems[safe: indexPath.row] {
            switch strongItem {
            case .actionWithIcon(let title, let titleColor, let image, _):
                if let cell = tableView.dequeueReusableCell(withIdentifier: "customAlertActionWithImageCell") as? AdcancedActionSheetActionWithImageCell {
                    cell.update(title: title, titleColor: titleColor, image: image)
                    cell.selectionStyle = .none
                    cell.bottomLine.isHidden = (indexPath.row == (actionItems.count - 1)) ? true : false
                    return cell
                }
                break
            case .normal(let id, let title, let deactivatable, _):
                if let cell = tableView.dequeueReusableCell(withIdentifier: "customAlertNormalCell") as? AdcancedActionSheetNormalCell {
                    cell.update(title: title, actionID: id)
                    cell.selectionStyle = .none
                    cell.bottomLine.isHidden = (indexPath.row == (actionItems.count - 1)) ? true : false
                    cell.setTitleAlpha(a: (deactivatable && self.selectedItemIDs.isEmpty) ? 0.5 : 1)
                    return cell
                }
                break
            case .selectable(let item):
                if let cell = tableView.dequeueReusableCell(withIdentifier: "customAlertComplexCell") as? AdcancedActionSheetComplexCell {
                    let selected = self.selectedItemIDs.contains(item.id)
                    cell.update(title: item.title, subtitle: item.subtitle, image: item.icon, imageTint: .asTickColor, actionID: item.id, drawBottomLine: item.drawBottomLine)
                    cell.setImageViewVisibility(selected)
                    cell.selectionStyle = .none
                    return cell
                }
                break
            case .quickGalleryCollectionView(let showCamera, _, _):
                if let cell = tableView.dequeueReusableCell(withIdentifier: "quickGalleryTableViewCell") as? QuickGalleryTableViewCell {
                    cell.updatePhotos(showCamera: showCamera)
                    cell.selectionStyle = .none
                    cell.delegate = self
                    return cell
                }
                break
            }
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let strongItem = self.actionItems[safe: indexPath.row] {
            switch strongItem {
            case .actionWithIcon( _, _, _, let completionHandler):
                completionHandler(self.selectedItemIDs)
                break
            case .normal(_, _, let deactivatable, let completionHandler):
                if deactivatable && self.selectedItemIDs.isEmpty {
                    return
                }
                completionHandler(self.selectedItemIDs)
                break
            case .selectable(let item):
                var isSelected = false
                for (index, id) in selectedItemIDs.enumerated() {
                    if id == item.id {
                        self.selectedItemIDs.remove(at: index)
                        isSelected = true
                        break
                    }
                }
                if !isSelected {
                    self.selectedItemIDs.append(item.id)
                }
                if let strongCell = tableView.cellForRow(at: indexPath) as? AdcancedActionSheetComplexCell {
                    strongCell.setImageViewVisibility(!isSelected)
                }
                updateDeactivatableButtonsAppearance()
                break
            default:
                break
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let strongItem = self.actionItems[safe: indexPath.row] {
            switch strongItem {
            case .quickGalleryCollectionView(completionHandler: _):
                return ((UIScreen.main.bounds.width / 2) >= Constants.quickGalleryHeight) ? Constants.quickGalleryHeight : (UIScreen.main.bounds.width / 2)
            default:
                return Constants.itemHeight
            }
        }
        return Constants.itemHeight
    }
    
    private func updateDeactivatableButtonsAppearance() {
        for cell in self.contentTableView.visibleCells {
            if let normalCell = cell as? AdcancedActionSheetNormalCell, let actionID = normalCell.actionID {
                let deactivatable = self.deactivatableButtonIDs.contains(actionID)
                normalCell.setTitleAlpha(a: (deactivatable && self.selectedItemIDs.isEmpty) ? 0.5 : 1)
            }
        }
    }
}

extension AdvancedActionSheet: QuickGalleryTableViewCellDelegate {
    internal func quickGalleryCellShouldOpenCamera() {
        for item in self.actionItems {
            switch item {
            case .quickGalleryCollectionView(_, _, let openCameraCallback):
                openCameraCallback()
            default:
                break
            }
        }
    }
    
    internal func quickGalleryCell(didselect: [PHAsset]) {
        if (self.selectedAssetsOfQuickGallery.isEmpty && didselect.isEmpty) || (self.selectedAssetsOfQuickGallery.count > 0 && didselect.count > 0) {
            self.selectedAssetsOfQuickGallery = didselect
            for cell in self.contentTableView.visibleCells {
                if let strongSendButtonCell = cell as? AdcancedActionSheetNormalCell, strongSendButtonCell.actionID == Constants.sendButtonIdConst {
                    let countText = (didselect.isEmpty) ? "" : " (\(didselect.count))"
                    strongSendButtonCell.titleLabel.text = String.send + countText
                }
            }
            return
        }
        self.selectedAssetsOfQuickGallery = didselect
        if didselect.isEmpty {
            self.prepareTableForNormalMode()
        } else {
            self.prepareTableForSendingMedias()
        }
        
        for cell in self.contentTableView.visibleCells {
            if let strongSendButtonCell = cell as? AdcancedActionSheetNormalCell, strongSendButtonCell.actionID == Constants.sendButtonIdConst {
                let countText = (didselect.isEmpty) ? "" : " (\(didselect.count))"
                strongSendButtonCell.titleLabel.text = String.send + countText
            }
        }
    }
}
