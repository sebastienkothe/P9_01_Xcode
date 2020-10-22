//
//  SceneDelegate.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 12/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

