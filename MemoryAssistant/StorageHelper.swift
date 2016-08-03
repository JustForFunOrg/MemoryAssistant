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

    let notificationTurnOn = "notificationState"

    let firstLaunch = "firtslaunch"

    let notificationTextKey = "notificationtext"
    let notificationPeriodicity = "notificationperiodicity"

    let defaultPeriodicity = Const.MINUTE * 15 // in seconds
    let defaultNotificationText = "Выровняй спину!"

    static let sharedInstance = StorageHelper()

    func isFirstLaunch() -> Bool {
        return !defaults.boolForKey(firstLaunch);
    }

    func setFirstLaunched() {
        defaults.setBool(true, forKey: firstLaunch)
    }

    func isNotificationTurnedOn() -> Bool {
        return isFirstLaunch() ? true : defaults.boolForKey(notificationTurnOn);
    }

    func setNotificationTurnedOn(value: Bool) {
        defaults.setBool(value, forKey: notificationTurnOn)
    }

    func notificationText() -> String {
        return isFirstLaunch() ? defaultNotificationText : defaults.stringForKey(notificationTextKey)!
    }

    func notificationText(text: String) {
        defaults.setValue(text.isEmpty ? defaultNotificationText: text, forKey: notificationTextKey)
    }

    func periodicity() -> Int { // in seocnds
        return isFirstLaunch() ? defaultPeriodicity : defaults.integerForKey(notificationPeriodicity)
    }

    func periodicity(value: Int) { // in seocnds
        defaults.setInteger(value, forKey: notificationPeriodicity)
    }
}
