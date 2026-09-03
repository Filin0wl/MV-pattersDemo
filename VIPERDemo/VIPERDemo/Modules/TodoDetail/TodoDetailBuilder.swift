import UIKit

enum TodoDetailBuilder {
    static func build(store: TodoStore, todoID: UUID) -> UIViewController {
        let view = TodoDetailViewController()
        let interactor = TodoDetailInteractor(store: store, todoID: todoID)
        let presenter = TodoDetailPresenter()
        let router = TodoDetailRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
