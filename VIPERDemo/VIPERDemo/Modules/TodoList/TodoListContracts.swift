import UIKit

protocol TodoListViewProtocol: AnyObject {
    func show(todos: [Todo])
}

protocol TodoListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAdd(title: String)
    func didToggle(at index: Int)
    func didDelete(at index: Int)
    func didSelect(at index: Int)
}

protocol TodoListInteractorInputProtocol: AnyObject {
    func fetchTodos()
    func addTodo(title: String)
    func toggleTodo(id: UUID)
    func deleteTodo(id: UUID)
}

protocol TodoListInteractorOutputProtocol: AnyObject {
    func didFetch(todos: [Todo])
}

protocol TodoListRouterProtocol: AnyObject {
    func openDetail(todoID: UUID)
}
