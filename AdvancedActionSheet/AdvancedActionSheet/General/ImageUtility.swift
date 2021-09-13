//
//  ImageUtility.swift
//  TestASAlert
//
//  Created by Ali Samaiee on 9/12/21.
//

import Foundation
import UIKit

internal class ImageUtility {
    static func getImage(named: String) -> UIImage? {
        let bundle = Bundle(for: Self.self)
        guard let resourceBundleURL = bundle.url(forResource: "AdvancedActionSheet", withExtension: "bundle")
        else { fatalError("AdvancedActionSheet.bundle not found!") }
        guard let resourceBundle = Bundle(url: resourceBundleURL)
        else { fatalError("Cannot access AdvancedActionSheet.bundle!") }
        let image = UIImage(named: named, in: resourceBundle, compatibleWith: nil)
        return image
    }
}
