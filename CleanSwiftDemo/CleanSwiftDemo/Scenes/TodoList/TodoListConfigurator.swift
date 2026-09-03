import UIKit

enum TodoListConfigurator {
    static func configure(viewController: TodoListViewController, store: TodoStore) {
        let interactor = TodoListInteractor(worker: TodoListWorker(store: store))
        let presenter = TodoListPresenter()
        let router = TodoListRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

enum TodoStoreHolder {
    static let shared = TodoStore()
}
