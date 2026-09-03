import UIKit

@objc protocol TodoListRoutingLogic {
    func routeToDetail()
}

protocol TodoListDataPassing {
    var dataStore: TodoListDataStore? { get }
}

final class TodoListRouter: NSObject, TodoListRoutingLogic, TodoListDataPassing {
    weak var viewController: TodoListViewController?
    var dataStore: TodoListDataStore?

    func routeToDetail() {
        guard let todoID = dataStore?.selectedTodoID else { return }
        let destination = TodoDetailViewController()
        TodoDetailConfigurator.configure(viewController: destination, todoID: todoID, store: TodoStoreHolder.shared)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
