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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        
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
                        print("First")

                    }
                } else if notifications.result.version != CoreDataManager.share.fetchPushNotificationsVersion()  {
                    CoreDataManager.share.savePushNotifications(guid: newNotifications.last?.guid ?? "", created_at: newNotifications.last?.created_at ?? "", message: newNotifications.last?.message ?? "")
                    CoreDataManager.share.editPushNotificationsVersion(version: notifications.result.version )
                    self.content.title = "\(newNotifications.last?.guid ?? "")"
                    self.content.body = "\(newNotifications.last?.message ?? "")"
                    print("no First")
                    self.sendNotification()

                } else {
                    return
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
