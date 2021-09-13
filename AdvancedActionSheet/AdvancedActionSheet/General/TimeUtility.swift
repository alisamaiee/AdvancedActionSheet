//
//  TimeUtility.swift
//  TestASAlert
//
//  Created by Ali Samaiee on 9/11/21.
//

import Foundation

internal struct TimeUtility {
    static func stringForFileDuration(durationInSeconds: Int) -> String {
        var result = ""
        if durationInSeconds < 60 { // Less than a minute
            result = (durationInSeconds < 10) ? "0:0\(durationInSeconds)" : "00:\(durationInSeconds)"
        } else if durationInSeconds >= 60 && durationInSeconds < (60*60) {// less than an hour
            let minutes = durationInSeconds / 60
            let seconds = durationInSeconds % 60
            result = (seconds < 10) ? "\(minutes):0\(seconds)" : "\(minutes):\(seconds)"
        } else if durationInSeconds >= (60*60) { // Over an hour
            let hours = durationInSeconds / (60*60)
            let minutes = (durationInSeconds % (60*60)) / 60
            let seconds = (durationInSeconds % (60*60)) % 60
            if minutes < 10 {
                result = (seconds < 10) ? "\(hours):0\(minutes):0\(seconds)" : "\(hours):0\(minutes):\(seconds)"
            } else {
                result = (seconds < 10) ? "\(hours):\(minutes):0\(seconds)" : "\(hours):\(minutes):\(seconds)"
            }
        }
        return result
    }
}
