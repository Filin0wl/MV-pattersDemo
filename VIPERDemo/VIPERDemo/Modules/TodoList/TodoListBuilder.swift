import UIKit

enum TodoListBuilder {
    static func build(store: TodoStore) -> UIViewController {
        let view = TodoListViewController()
        let interactor = TodoListInteractor(store: store)
        let presenter = TodoListPresenter()
        let router = TodoListRouter(store: store)

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
