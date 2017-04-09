//
//  ViewController.swift
//  NotifyMe
//
//  Created by Kalyan Dechiraju on 09/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Request for Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if !success {
                print(error.debugDescription)
            }
        }
    }

    @IBAction func notifyButtonPressed(_ sender: UIButton) {
        scheduleNotification(inSeconds: 5) { (success) in
            if success {
                print("Notification sent")
            } else {
                print("Error in notification")
            }
        }
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let notification = UNMutableNotificationContent()
        notification.title = "First Notification"
        notification.subtitle = Date().description.capitalized
        notification.body = "I will soon be an iOS Developer"
        notification.categoryIdentifier = "NotifyMeCategory"
        // Add an attachment
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "NotifyMe", url: imageUrl, options: .none)
        
        notification.attachments = [attachment]
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "NotifyMe", content: notification, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print(error!)
                completion(false)
            } else {
                completion(true)
            }
        }
    }

}

