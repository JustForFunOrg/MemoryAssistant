//
//  ViewController.swift
//  MemoryAssistant
//
//  Created by vmalikov on 7/30/16.
//  Copyright © 2016 justForFun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var notificationState: UISwitch!

    let app = UIApplication.sharedApplication()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        notificationState.setOn(StorageHelper.sharedInstance.isNotificationTurnedOn(), animated: false)
    }

    override func viewDidDisappear(animated: Bool) {
        if StorageHelper.sharedInstance.isFirstLaunch() {
            StorageHelper.sharedInstance.setFirstLaunched()
        }
        super.viewDidDisappear(animated)
    }

    func setupTimer() {
        let seconds = StorageHelper.sharedInstance.periodicity()
        let delay = Double(seconds) * Double(NSEC_PER_SEC) // nanoseconds per seconds

        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))

        weak var weakSelf = self
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            if let state = weakSelf?.notificationState {
                if state.on {
                    weakSelf?.sendLocalNotification()
                    weakSelf?.setupTimer()
                }
            }
        })
    }

    @IBAction func sendNotification(sender: UIButton) {
        setupTimer()
    }

    func sendLocalNotification() {

        let notifyAlarm = UILocalNotification()

        notifyAlarm.fireDate = NSDate()
        notifyAlarm.timeZone = NSTimeZone.defaultTimeZone()
        notifyAlarm.soundName = UILocalNotificationDefaultSoundName
        notifyAlarm.category = "memoryAssistant"
        notifyAlarm.alertBody = "\(StorageHelper.sharedInstance.notificationText())"
        app.scheduleLocalNotification(notifyAlarm)
    }

    override func viewWillDisappear(animated: Bool) {
        StorageHelper.sharedInstance.setNotificationTurnedOn(notificationState.on)
    }

    @IBAction func notificationStateChanged(sender: UISwitch) {
        StorageHelper.sharedInstance.setNotificationTurnedOn(sender.on)
    }
}

