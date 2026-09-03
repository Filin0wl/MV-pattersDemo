import UIKit

enum AppStore {
    static let shared = TodoStore()
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController(rootViewController: TodoListBuilder.build(store: AppStore.shared))
        navigation.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigation
        window.tintColor = .systemGreen
        window.makeKeyAndVisible()
        self.window = window
    }
}

