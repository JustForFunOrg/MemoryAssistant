//
//  SettingsViewController.swift
//  MemoryAssistant
//
//  Created by vmalikov on 7/30/16.
//  Copyright © 2016 justForFun. All rights reserved.
//

import UIKit
import Darwin

class SettingsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {

    @IBOutlet weak var notificationText: UITextField!
    @IBOutlet weak var soundsNotificationSwitch: UISwitch!
    @IBOutlet weak var vibrationNotificationSwitch: UISwitch!
    @IBOutlet weak var timePicker: UIDatePicker!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTimePicker()
    }

    override func didMoveToParentViewController(parent: UIViewController?) {
        if let text = notificationText.text {
            Const.sharedInstance.notificationText(text)
        } else {
            Const.sharedInstance.notificationText("")
        }

        timePickerChanged()

        super.didMoveToParentViewController(parent)
    }

    func setupTimePicker() {
        timePicker.datePickerMode = UIDatePickerMode.Time
        timePicker.locale = NSLocale(localeIdentifier: "da_DK")

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "HH:mm"

        let periodicity = Const.sharedInstance.periodicity()
        let periodicityInHours = Int(floor(Double(periodicity) / Double(Const.HOUR)))
        let periodicityInMinutes = (periodicity - (periodicityInHours * Const.HOUR)) / Const.MINUTE

        let date = dateFormatter.dateFromString("\(periodicityInHours):\(periodicityInMinutes)")
        timePicker.setDate(date!, animated: false)
    }

    func timePickerChanged() {
        let date = timePicker.date

        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        let periodicity = (Const.HOUR * components.hour + components.minute * Const.MINUTE)

        Const.sharedInstance.periodicity(periodicity)
    }

    func localResignFirstResponder() {
        notificationText.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        localResignFirstResponder()
    }
}
