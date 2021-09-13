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
        return UIImage(named: named, in: Bundle(for: ImageUtility.self), compatibleWith: nil)
    }
}
