# AdvancedActionSheet - iOS
A customizable, full-feature, lightweight iOS framework to be used instead of UIAlertController.

<img align="left" src="./AdvancedActionSheetExamples/ScreenShots/5.gif?raw" width="225" height="487">
<img align="left" src="./AdvancedActionSheetExamples/ScreenShots/1.jpg?raw" width="225" height="487">
<img align="left" src="./AdvancedActionSheetExamples/ScreenShots/2.jpg?raw" width="225" height="487">
<img align="left" src="./AdvancedActionSheetExamples/ScreenShots/3.jpg?raw" width="225" height="487">
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

### Import it to your project:
```swift
import AdvancedActionSheet
```

### Then create an instance of AdvancedActionSheet, add actions and present it:

```swift
let alert = AdvancedActionSheet()
alert.addAction(item: .normal(id: 0, title: "Action 1", completionHandler: { (_) in
    alert.dismiss(animated: true)
 }))
alert.addAction(item: .normal(id: 1, title: "Action 2", completionHandler: { (_) in
    alert.dismiss(animated: true)
 }))
alert.present(presenter: self, completion: nil)
```
