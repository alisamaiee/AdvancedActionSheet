//
//  AdvancedActionSheetConfigs.swift
//  TestASAlert
//
//  Created by Ali Samaiee on 9/12/21.
//

import Foundation
import UIKit

/// Customize action sheet in the way you like
public struct AdvancedActionSheetConfigs {
    
    /**
     You can change alert texts to fit your application language
     Passing nil will make no change on related property
     */
    public static func configLanguage(cancel: String? = nil,
                               send: String? = nil,
                               sendAsFile: String? = nil,
                               ok: String? = nil,
                               error: String? = nil,
                               permissionDenied: String? = nil,
                               settings: String? = nil,
                               noAccessToGalleryDescription: String? = nil) {
        String.cancel =                       cancel ?? String.cancel
        String.send =                         send ?? String.send
        String.sendAsFile =                   sendAsFile ?? String.sendAsFile
        String.ok =                           ok ?? String.ok
        String.error =                        error ?? String.error
        String.permissionDenied =             permissionDenied ?? String.permissionDenied
        String.settings =                     settings ?? String.settings
        String.noAccessToGalleryDescription = noAccessToGalleryDescription ?? String.noAccessToGalleryDescription
    }
    
    /**
     You can change alert colors to fit your application theme
     Passing nil will make no change on related property
     */
    public static func configColors(text: UIColor? = nil,
                             alertDivider: UIColor? = nil,
                             alertBackground: UIColor? = nil,
                             checkBoxBorder: UIColor? = nil,
                             roundCheckBoxChecked: UIColor? = nil,
                             tickColor: UIColor? = nil) {
        UIColor.asText =                text ?? UIColor.asText
        UIColor.asAlertDivider =        alertDivider ?? UIColor.asAlertDivider
        UIColor.asAlertBackground =     alertBackground ?? UIColor.asAlertBackground
        UIColor.asCheckBoxBorder =      checkBoxBorder ?? UIColor.asCheckBoxBorder
        UIColor.asRoundChecboxChekced = roundCheckBoxChecked ?? UIColor.asRoundChecboxChekced
        UIColor.asTickColor =           tickColor ?? UIColor.asTickColor
    }
    
    /**
     You can change alert fonts to fit your application appearance
     Passing nil will make no change on related property
     */
    public static func configFonts(title: UIFont? = nil,
                            subtitle: UIFont? = nil,
                            cancel: UIFont? = nil,
                            videoDuration: UIFont? = nil) {
        UIFont.titleFont =         title ?? UIFont.titleFont
        UIFont.subtitleFont =      subtitle ?? UIFont.subtitleFont
        UIFont.cancelFont =        cancel ?? UIFont.cancelFont
        UIFont.videoDurationFont = videoDuration ?? UIFont.videoDurationFont
    }
}
