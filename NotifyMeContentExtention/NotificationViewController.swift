//
//  NotificationViewController.swift
//  NotifyMeContentExtention
//
//  Created by Kalyan Dechiraju on 09/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {
            print("error")
            return
        }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            if let imageData = try? Data.init(contentsOf: attachment.url) {
                imageView.image = UIImage(data: imageData)
            }
            
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        completion(.dismissAndForwardAction)
    }

}
