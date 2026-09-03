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
        let list = TodoListViewController()
        TodoListConfigurator.configure(viewController: list, store: TodoStoreHolder.shared)
        let navigation = UINavigationController(rootViewController: list)
        navigation.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigation
        window.tintColor = .systemTeal
        window.makeKeyAndVisible()
        self.window = window
    }
}

