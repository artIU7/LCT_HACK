//
//  AppDelegate.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import UIKit
import NMAKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appID = "7T8UgnMEkQDNCeJH182A"
    let appCODE = "wfyqs2ZxyVaiTgdkqDnIcQ"
    let licenseKEY = "kDvRN5xPz055M13RA0wgvRIfffbsbwtmMgO0KKbdTntw8+o4J0FphfHQ+eWlsdTDv0hrpouNhVIwJ/YMGMviTvKxK3sOPNAuDK5R8uWhio3iZoORiVPWhyqfSt+4NmhEYBWTdJVE3F6gD/HKuiDoKmGupllA6cE3m8OMQzjyDskJQXor91ipNwmE3oGBy/A+A+zR4CO6SYydzlFPh+yF2TVF42DyKPF7km+Dk7m02IjsSBxiIb0UKZx5ldqnG5R+5MAhn5x6vcfbk1YynNVkd8qCk0LXuyBbXA87gk0HUxypFnaWUMqgoBylVJWAliF3p2X7yVX+s8wIBNULI9/c/uSLWPTLb7zqqHIn1lyMeR/MoLBNLzY+h4LBeMWX+0tT/jWYSjubQ2/q14j++CSw9LvHcYaADHv0wJYf0jzJaTyCK0EOb2cBgaqg4QRjSDIIKyrFfbVn2SEmAutZYnhl0Geb9mEVAFq6ljX3THJkrslvXCt2vrFLzjmCmSDRDh0mJ2Nwugj+D6rXS2QDCYE/yBSdekfYe3z/BiJwD5Bfj2YOQaygKNFXy1CCaGZOzFp0kbXdQFWfIeLyDoM0M3cL+luVM/0gLQu5f3xwyUSIQXikJedr141Cf9xRjSWpgfe6Ri/6G/VPAI+LFOHu7jHHfQPfr2dhKVTj+KLA2/xbbCs="

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NMAApplicationContext.setAppId(appID,
                                       appCode: appCODE,
                                       licenseKey: licenseKEY)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

