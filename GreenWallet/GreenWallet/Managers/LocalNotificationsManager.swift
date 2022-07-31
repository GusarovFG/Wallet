//
//  LocalNotificationsManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 11.07.2022.
//

import Foundation
import UserNotifications

class LocalNotificationsManager: NSObject {
    
    static let share = LocalNotificationsManager()
    let notificationCenter = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    
    private override init(){
        
        
    }
    
    func sendNotification() {
        self.notificationCenter.delegate = self
        
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "noticication", content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            print(error?.localizedDescription)
        }
    }
    
    func checkUpdates() {
        
        let oldNotifications = CoreDataManager.share.fetchPushNotifications()
        var newNotifications: [PushNotificationsList] = []
        
        DispatchQueue.global().async {
            NetworkManager.share.getPushNotifications { notifications in
                newNotifications = notifications.result.list
                
                if CoreDataManager.share.fetchPushNotifications().isEmpty {
                    CoreDataManager.share.savePushNotificationsVersion(version: notifications.result.version)
                    for i in newNotifications {
                        CoreDataManager.share.savePushNotifications(guid: i.guid , created_at: i.created_at, message: i.message)
                        
                    }
                } else if notifications.result.version != CoreDataManager.share.fetchPushNotificationsVersion()  {
                    CoreDataManager.share.editPushNotificationsVersion(version: notifications.result.version )
                    for i in newNotifications {
                        if CoreDataManager.share.fetchPushNotifications().filter({$0.guid == i.guid}).count == 0 {
                            CoreDataManager.share.savePushNotifications(guid: i.guid , created_at: i.created_at, message: i.message)
                            self.content.title = "\(newNotifications.first?.guid ?? "")"
                            self.content.body = "\(newNotifications.first?.message ?? "")"
                            print("no First")
                            self.sendNotification()
                        } else {
                            continue
                        }
                        
                    }
                }
                
            }
        }
    }
}

extension LocalNotificationsManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        print(#function)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
    
}
