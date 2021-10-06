//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by GrowApp on 31.05.2021.
//

import UIKit
import Realm
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SplashScreenConfigurator.create()
        self.window?.makeKeyAndVisible()
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(granted, error) in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
                print(settings)
            }
        })
        notificationCenter.delegate = self
        sendNotification()
        return true
    }
    
    func sendNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Rick and Morty"
        content.body = "We are pleased that you are using our app. Welcome back"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription)
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        print(#function)
    }
}
