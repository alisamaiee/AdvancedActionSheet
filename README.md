# AdvancedActionSheet - iOS
### A customizable, full-feature, lightweight iOS framework to be used instead of UIAlertController.

<img align="left" src="./AdvancedActionSheetExamples/ScreenShots/1.jpg?raw" width="225" height="487">
<img align="left" src="./AdvancedActionSheetExamples/ScreenShots/2.jpg?raw" width="225" height="487">
<img src="./AdvancedActionSheetExamples/ScreenShots/4.jpg?raw" width="225" height="487">

## Cocoapods
AdvancedActionSheet is available through [CocoaPods](http://cocoapods.org). Simply add the following to your Podfile:

```ruby
use_frameworks!

target '<Your Target Name>' do
  pod 'AdvancedActionSheet'
end
```

## How to use

* Import it to your project:
```swift
import AdvancedActionSheet
```

* Then create an instance of AdvancedActionSheet, add actions and present it:
```swift
let alert = AdvancedActionSheet()
alert.addAction(item: .normal(id: 0, title: "Action 1", completionHandler: { (_) in
    // User tapped on this action, do appropriate tasks
    alert.dismiss(animated: true)
}))
alert.addAction(item: .normal(id: 1, title: "Action 2", completionHandler: { (_) in
    // User tapped on this action, do appropriate tasks
    alert.dismiss(animated: true)
}))
alert.present(presenter: self, completion: nil)
```
<img src="./AdvancedActionSheetExamples/ScreenShots/3.jpg?raw" width="225" height="487">

* add actions with image:
```swift
let alert = AdvancedActionSheet()
alert.addAction(item: .actionWithIcon(title: "Maps", titleColor: nil, image: UIImage(named: "maps") ?? UIImage(), completionHandler: { (_) in
    // User tapped on this action, do appropriate tasks
    alert.dismiss(animated: true)
}))
alert.addAction(item: .actionWithIcon(title: "Waze", titleColor: nil, image: UIImage(named: "waze") ?? UIImage(), completionHandler: { (_) in
    // User tapped on this action, do appropriate tasks
    alert.dismiss(animated: true)
}))
alert.addAction(item: .actionWithIcon(title: "Google Maps", titleColor: nil, image: UIImage(named: "google-maps") ?? UIImage(), completionHandler: { (_) in
    // User tapped on this action, do appropriate tasks
    alert.dismiss(animated: true)
}))
alert.present(presenter: self, completion: nil)
```
<img src="./AdvancedActionSheetExamples/ScreenShots/4.jpg?raw" width="225" height="487">

* add selectable actions:
```swift
let alert = AdvancedActionSheet()
alert.addAction(item: .selectable(item: SelectableActionItem(id: 1, icon: nil, title: "USA", subtitle: "United States", defaultSelectionStatus: false, drawBottomLine: true)))
alert.addAction(item: .selectable(item: SelectableActionItem(id: 2, icon: nil, title: "UK", subtitle: "United Kingdom", defaultSelectionStatus: true, drawBottomLine: true)))
alert.addAction(item: .selectable(item: SelectableActionItem(id: 3, icon: nil, title: "Germany", subtitle: "🇩🇪", defaultSelectionStatus: true, drawBottomLine: true)))
alert.addAction(item: .selectable(item: SelectableActionItem(id: 4, icon: nil, title: "Utopia", subtitle: "🤨", defaultSelectionStatus: true, drawBottomLine: true)))
alert.addAction(item: .selectable(item: SelectableActionItem(id: 5, icon: nil, title: "Ant Title", subtitle: "Any description", defaultSelectionStatus: false, drawBottomLine: true)))
// - deactivatable: will deactivate action when no selectable is selected, and reactivate it as soon as one of them become selected
alert.addAction(item: .normal(id: 6, title: "Done", deactivatable: false, completionHandler: { (selectedIDs) in
    print(selectedIDs)
    alert.dismiss(animated: true)
}))
alert.present(presenter: self, completion: nil)
```
<img src="./AdvancedActionSheetExamples/ScreenShots/1.jpg?raw" width="225" height="487">

* add gallery+camera action:
```swift
let alert = AdvancedActionSheet()
alert.addAction(item: .quickGalleryCollectionView(showCamera: true, completionHandler: { (assets, selectedActionIDs, sendAsFile) in
    // User tapped on send (as file or with compression) button
    // with selected assets &
    // selected selectable actions if there is any of them (in this example we have no selectable action while having gallery action)
    alert.dismiss(animated: true)
}, {
    // User tapped on camera, open camera as you wish (you can use UIImagePickerController)
    alert.dismiss(animated: true)
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
```
<img src="./AdvancedActionSheetExamples/ScreenShots/5.gif?raw" width="225" height="487">

## Customize it:
You can customize theme (colors), fonts and even language (texts). It will fit in your application.

* Config theme (colors):
```swift
// Just call this method
AdvancedActionSheetConfigs.configColors
```
* Config fonts:
```swift
// Just call this method
AdvancedActionSheetConfigs.configFonts
```
* Config language (texts):
```swift
// Just call this method
AdvancedActionSheetConfigs.configLanguage
```
