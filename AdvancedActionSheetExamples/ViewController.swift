//
//  ViewController.swift
//  AdvancedActionSheetExamples
//
//  Created by Ali Samaiee on 9/13/21.
//

import UIKit
import AdvancedActionSheet

class SampleButton: UIButton {
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 5
        self.titleEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {
    
    let selectableButton: UIButton = {
        let button = SampleButton()
        button.setTitle("Selectable Actions", for: .normal)
        return button
    }()
    
    let galleryButton: UIButton = {
        let button = SampleButton()
        button.setTitle("Gallery & Actions", for: .normal)
        return button
    }()
    
    let normalButton: UIButton = {
        let button = SampleButton()
        button.setTitle("Normal Actions", for: .normal)
        return button
    }()
    
    let withIconButton: UIButton = {
        let button = SampleButton()
        button.setTitle("Action With Image", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(selectableButton)
        self.selectableButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.selectableButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        self.selectableButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        
        self.selectableButton.addTarget(self, action: #selector(selectableButtonAction), for: .touchUpInside)
        
        self.view.addSubview(galleryButton)
        self.galleryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.galleryButton.topAnchor.constraint(equalTo: self.selectableButton.bottomAnchor, constant: 50).isActive = true
        self.galleryButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true

        self.galleryButton.addTarget(self, action: #selector(galleryButtonAction), for: .touchUpInside)
        
        self.view.addSubview(normalButton)
        self.normalButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.normalButton.topAnchor.constraint(equalTo: self.galleryButton.bottomAnchor, constant: 50).isActive = true
        self.normalButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true

        self.normalButton.addTarget(self, action: #selector(normalButtonAction), for: .touchUpInside)
        
        self.view.addSubview(withIconButton)
        self.withIconButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.withIconButton.topAnchor.constraint(equalTo: self.normalButton.bottomAnchor, constant: 50).isActive = true
        self.withIconButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true

        self.withIconButton.addTarget(self, action: #selector(withIconButtonAction), for: .touchUpInside)
    }

    @objc func selectableButtonAction() {
        let alert = AdvancedActionSheet()
        alert.addAction(item: .selectable(item: SelectableActionItem(id: 1, icon: nil, title: "USA", subtitle: "United States", defaultSelectionStatus: false, drawBottomLine: true)))
        alert.addAction(item: .selectable(item: SelectableActionItem(id: 2, icon: nil, title: "UK", subtitle: "United Kingdom", defaultSelectionStatus: true, drawBottomLine: true)))
        alert.addAction(item: .selectable(item: SelectableActionItem(id: 3, icon: nil, title: "Germany", subtitle: "🇩🇪", defaultSelectionStatus: true, drawBottomLine: true)))
        alert.addAction(item: .selectable(item: SelectableActionItem(id: 4, icon: nil, title: "Utopia", subtitle: "🤨", defaultSelectionStatus: true, drawBottomLine: true)))
        alert.addAction(item: .selectable(item: SelectableActionItem(id: 5, icon: nil, title: "Ant Title", subtitle: "Any description", defaultSelectionStatus: false, drawBottomLine: true)))
        alert.addAction(item: .normal(id: 6, title: "Done", deactivatable: false, completionHandler: { (selectedIDs) in
            alert.dismiss(animated: true)
            print(selectedIDs)
        }))
        
        alert.present(presenter: self, completion: nil)
    }
    
    @objc func galleryButtonAction() {
        let alert = AdvancedActionSheet()
        alert.addAction(item: .quickGalleryCollectionView(showCamera: true, completionHandler: { (assets, selectedActionIDs, sendAsFile) in
            // Do the things you want
        }, {
            // Open camera as you wish (you can use UIImagePickerController)
        }))
        alert.addAction(item: .normal(id: 0, title: "Contacts", deactivatable: false, completionHandler: { (selectedIDs) in
            // User tapped on this action, do appropriate tasks
            alert.dismiss(animated: true)
        }))
        alert.addAction(item: .normal(id: 1, title: "Location", deactivatable: false, completionHandler: { (selectedIDs) in
            // User tapped on this action, do appropriate tasks
            alert.dismiss(animated: true)
        }))
        alert.addAction(item: .normal(id: 2, title: "iCloud", deactivatable: false, completionHandler: { (selectedIDs) in
            // User tapped on this action, do appropriate tasks
            alert.dismiss(animated: true)
        }))
        
        alert.present(presenter: self, completion: nil)
    }
    
    @objc func normalButtonAction() {
        let alert = AdvancedActionSheet()
        alert.addAction(item: .normal(id: 0, title: "Action 1", completionHandler: { (_) in
            alert.dismiss(animated: true)
        }))
        alert.addAction(item: .normal(id: 1, title: "Action 2", completionHandler: { (_) in
            alert.dismiss(animated: true)
        }))

        alert.present(presenter: self, completion: nil)
    }
    
    @objc func withIconButtonAction() {
        let alert = AdvancedActionSheet()
        alert.addAction(item: .actionWithIcon(title: "Maps", titleColor: nil, image: UIImage(named: "maps") ?? UIImage(), completionHandler: { (_) in
            alert.dismiss(animated: true)
        }))
        alert.addAction(item: .actionWithIcon(title: "Waze", titleColor: nil, image: UIImage(named: "waze") ?? UIImage(), completionHandler: { (_) in
            alert.dismiss(animated: true)
        }))
        alert.addAction(item: .actionWithIcon(title: "Google Maps", titleColor: nil, image: UIImage(named: "google-maps") ?? UIImage(), completionHandler: { (_) in
            alert.dismiss(animated: true)
        }))

        alert.present(presenter: self, completion: nil)
    }
}
