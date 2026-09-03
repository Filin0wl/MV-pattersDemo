import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController(rootViewController: TodoListViewController(store: TodoStore()))
        navigation.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigation
        window.tintColor = .systemBlue
        window.makeKeyAndVisible()
        self.window = window
    }
}

