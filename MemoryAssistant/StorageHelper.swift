//
//  Const.swift
//  MemoryAssistant
//
//  Created by vmalikov on 7/31/16.
//  Copyright © 2016 justForFun. All rights reserved.
//

import UIKit

class StorageHelper {

    let defaults = NSUserDefaults.standardUserDefaults()

    let NOTIFICATION_TURN_ON = "notificationState"

    let FIRST_LAUNCH = "firtslaunch"

    let NOTIFICATION_TEXT = "notificationtext"
    let NOTIFICATION_PERIODICITY = "notificationperiodicity"

    let DEFAULT_PERIODICITY = Const.MINUTE * 15 // in seconds
    let DEFAULT_NOTIFICATION_TEXT = "Выровняй спину!"

    static let sharedInstance = StorageHelper()

    func isFirstLaunch() -> Bool {
        return !defaults.boolForKey(FIRST_LAUNCH);
    }

    func setFirstLaunched() {
        defaults.setBool(true, forKey: FIRST_LAUNCH)
    }

    func isNotificationTurnedOn() -> Bool {
        return isFirstLaunch() ? true : defaults.boolForKey(NOTIFICATION_TURN_ON);
    }

    func setNotificationTurnedOn(value: Bool) {
        defaults.setBool(value, forKey: NOTIFICATION_TURN_ON)
    }

    func notificationText() -> String {
        return isFirstLaunch() ? DEFAULT_NOTIFICATION_TEXT : defaults.stringForKey(NOTIFICATION_TEXT)!
    }

    func notificationText(text: String) {
        defaults.setValue(text.isEmpty ? DEFAULT_NOTIFICATION_TEXT: text, forKey: NOTIFICATION_TEXT)
    }

    func periodicity() -> Int { // in seocnds
        return isFirstLaunch() ? DEFAULT_PERIODICITY : defaults.integerForKey(NOTIFICATION_PERIODICITY)
    }

    func periodicity(value: Int) { // in seocnds
        defaults.setInteger(value, forKey: NOTIFICATION_PERIODICITY)
    }
}
