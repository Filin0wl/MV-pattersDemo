import UIKit

final class TodoListRouter: TodoListRouterProtocol {
    weak var viewController: UIViewController?
    private let store: TodoStore

    init(store: TodoStore) {
        self.store = store
    }

    func openDetail(todoID: UUID) {
        let detail = TodoDetailBuilder.build(store: store, todoID: todoID)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
}
