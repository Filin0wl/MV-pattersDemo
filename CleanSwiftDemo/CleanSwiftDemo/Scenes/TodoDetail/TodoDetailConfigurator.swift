import Foundation

enum TodoDetailConfigurator {
    static func configure(viewController: TodoDetailViewController, todoID: UUID, store: TodoStore) {
        let interactor = TodoDetailInteractor(worker: TodoDetailWorker(store: store))
        interactor.todoID = todoID
        let presenter = TodoDetailPresenter()
        let router = TodoDetailRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
