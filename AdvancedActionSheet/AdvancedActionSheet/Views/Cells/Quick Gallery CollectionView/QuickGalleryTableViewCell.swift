//
//  QuickGalleryTableViewCell.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 11/11/19.
//  Copyright © 2021 Ali Samaiee. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol QuickGalleryTableViewCellDelegate {
    func quickGalleryCell(didselect: [PHAsset])
    func quickGalleryCellShouldOpenCamera()
}

class QuickGalleryTableViewCell: UITableViewCell {
    
    struct Constants {
        static let rowHeight: CGFloat = 58
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let minimumInteritemSpacing: CGFloat = 6
        static let minimumLineSpacing: CGFloat = 6
        static let maxHeight: CGFloat = UIScreen.main.bounds.width / 2
        static let multiplier: CGFloat = 2
        static let animationDuration: TimeInterval = 0.3
    }
    
    // MARK: Properties
    
    var delegate: QuickGalleryTableViewCellDelegate? = nil
    
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        guard let self = self else { return UICollectionView() }
        $0.dataSource = self
        $0.delegate = self
        $0.allowsMultipleSelection = true
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.decelerationRate = UIScrollView.DecelerationRate.fast
        if #available(iOS 11.0, *) {
            $0.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        $0.contentInset = Constants.insets
        $0.backgroundColor = .clear
        $0.layer.masksToBounds = true
        $0.clipsToBounds = false
        $0.backgroundColor = UIColor.clear
        $0.register(QuickGalleryCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: QuickGalleryCollectionViewCell.self))
        $0.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CameraCollectionViewCell.self))
        
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    fileprivate lazy var layout: PhotoLayout = { [weak self] in
        guard let self = self else { return PhotoLayout() }
        $0.delegate = self
        $0.lineSpacing = Constants.minimumLineSpacing
        return $0
    }(PhotoLayout())
    
    var items = [QuickGalleryCollectionViewItemType]()
    lazy var assets = [PHAsset]()
    var assetsIdDict = [String: Int]()
    lazy var selectedAssets = [PHAsset]()
    var selection: (([PHAsset]) -> Void)?
    
    var cameraCell: CameraCollectionViewCell? = nil
    let showCamera: Bool = true
    
    var preferredHeight: CGFloat {
        return Constants.maxHeight / (selectedAssets.isEmpty ? Constants.multiplier : 1) + Constants.insets.top + Constants.insets.bottom
    }
    
    func sizeFor(asset: PHAsset) -> CGSize {
        let height: CGFloat = Constants.maxHeight
        let width: CGFloat = CGFloat(Double(height) * Double(asset.pixelWidth) / Double(asset.pixelHeight))
        return CGSize(width: width, height: height)
    }
    
    func sizeForItem(asset: PHAsset) -> CGSize {
        let size: CGSize = sizeFor(asset: asset)
        if selectedAssets.isEmpty {
            let value: CGFloat = size.height / Constants.multiplier
            return CGSize(width: value, height: value)
        } else {
            return size
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot init with coder")
    }
    
    func postInit() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.collectionView)
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func updatePhotos(showCamera: Bool) {
        checkStatus { [weak self] assets in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.assets.removeAll()
                self.assets.append(contentsOf: assets)
                
                self.items.removeAll()
                if showCamera {
                    self.items.append(.camera)
                }
                for asset in self.assets {
                    self.items.append(.asset(asset))
                }
                
                self.collectionView.reloadData()
            }
        }
    }
    
    func checkStatus(completionHandler: @escaping ([PHAsset]) -> ()) {
        debugPrint("AdvancedActionSheet: PHPhotoLibrary.authorizationStatus = \(PHPhotoLibrary.authorizationStatus())")
        switch PHPhotoLibrary.authorizationStatus() {
            
        case .notDetermined:
            /// This case means the user is prompted for the first time for allowing contacts
            Assets.requestAccess { [weak self] status in
                self?.checkStatus(completionHandler: completionHandler)
            }
            
        case .authorized:
            /// Authorization granted by user for this app.
            DispatchQueue.main.async { [weak self] in
                self?.fetchPhotos(completionHandler: completionHandler)
            }
            
        case .denied, .restricted:
            /// User has denied the current app to access the contacts.
            DispatchQueue.main.async {
                let productName = Bundle(for: AdvancedActionSheet.self).infoDictionary!["CFBundleName"]!
                let alert = UIAlertController(title: .permissionDenied, message: "\(productName) " + String.noAccessToGalleryDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: .settings, style: .destructive, handler: { (action) in
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                }))
                alert.addAction(UIAlertAction(title: .ok, style: .cancel, handler: { (action) in
                    //self.alertController?.dismiss(animated: true)
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    func fetchPhotos(completionHandler: @escaping ([PHAsset]) -> ()) {
        Assets.fetch(fetchLimit: 50) { (result) in
            switch result {
                
            case .success(let assets):
                completionHandler(assets)
                
            case .error(let error):
                debugPrint("AdvancedActionSheet: error on fetching photos")
                let alert = UIAlertController(title: .error, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: .ok, style: .cancel, handler: { (action) in
                    //self.alertController?.dismiss(animated: true)
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func action(withAsset asset: PHAsset, at indexPath: IndexPath) {
        let previousCount = selectedAssets.count
        
        self.assetsIdDict[asset.localIdentifier] = (selectedAssets.contains(asset)) ? nil : 0
        selectedAssets.contains(asset)
            ? selectedAssets.remove(asset)
            : selectedAssets.append(asset)
        selection?(selectedAssets)
        
        let currentCount = selectedAssets.count
        
        if (previousCount == 0 && currentCount > 0) || (previousCount > 0 && currentCount == 0) {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.layout.invalidateLayout()
                self?.layoutSubviews()
                })
        } else {
            self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }

        self.delegate?.quickGalleryCell(didselect: selectedAssets)
        //tableView.reloadData()
    }
    
    func cleanupOnDismiss() {
        self.delegate = nil
        self.cameraCell?.cameraView.stopSession()
        for cell in self.collectionView.visibleCells {
            if let strongCell = cell as? QuickGalleryCollectionViewCell {
                strongCell.imageView.image = nil
            }
        }
    }
}

extension QuickGalleryTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = self.items[safe: indexPath.item] {
            switch item {
            case .camera:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CameraCollectionViewCell.self), for: indexPath) as? CameraCollectionViewCell else { return UICollectionViewCell() }
                if self.cameraCell == nil {
                    self.cameraCell = cell
                }
                return cell
            case .asset(let asset):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuickGalleryCollectionViewCell.self), for: indexPath) as? QuickGalleryCollectionViewCell else { return UICollectionViewCell() }
                let size = sizeFor(asset: asset)
                let isSelected = self.assetsIdDict[asset.localIdentifier] == nil ? false : true
                DispatchQueue.main.async {
                    cell.checkBox.setOn(isSelected, animated: true)
                    Assets.resolve(asset: asset, size: size) { new in
                        cell.imageView.image = new
                    }
                    if asset.mediaType == .video {
                        let durationStr = TimeUtility.stringForFileDuration(durationInSeconds: Int(asset.duration))
                        cell.updateLabel(text: durationStr)
                    } else {
                        cell.updateLabel(text: "")
                    }
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = self.items[safe: indexPath.item] {
            switch item {
            case .camera:
                self.delegate?.quickGalleryCellShouldOpenCamera()
            case .asset(let asset):
                layout.selectedCellIndexPath = layout.selectedCellIndexPath == indexPath ? nil : indexPath
                action(withAsset: asset, at: indexPath)
                if let strongCell = self.collectionView.cellForItem(at: indexPath) as? QuickGalleryCollectionViewCell {
                    strongCell.checkBox.setOn(true, animated: true)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let item = self.items[safe: indexPath.item] {
            switch item {
            case .camera:
                break
            case .asset(let asset):
                action(withAsset: asset, at: indexPath)
                if let strongCell = self.collectionView.cellForItem(at: indexPath) as? QuickGalleryCollectionViewCell {
                    strongCell.checkBox.setOn(false, animated: true)
                }
            }
        }
    }
}

extension QuickGalleryTableViewCell: PhotoLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        if let item = self.items[safe: indexPath.item] {
            switch item {
            case .camera:
                break
            case .asset(let asset):
                let size: CGSize = sizeForItem(asset: asset)
                return size
            }
        }
        return CGSize(width: 100, height: 100)
    }
}

enum QuickGalleryCollectionViewItemType {
    case asset(PHAsset)
    case camera
}
