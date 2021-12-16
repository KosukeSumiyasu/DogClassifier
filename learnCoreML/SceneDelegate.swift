//
//  SceneDelegate.swift
//  learnCoreML
//
//  Created by Kousuke Sumiyasu on 2021/12/15.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }

        if let windowScene = scene as? UIWindowScene {
            // 1. 初期化
            let window = UIWindow(windowScene: windowScene)
            window.makeKeyAndVisible()

            // 2. 最初に表示する画面を設定
            let rootViewController = PredictionViewController()
            window.rootViewController = rootViewController

            self.window = window
        }
    }
}
