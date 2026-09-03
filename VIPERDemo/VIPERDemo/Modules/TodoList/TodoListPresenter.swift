import Foundation

final class TodoListPresenter: TodoListPresenterProtocol, TodoListInteractorOutputProtocol {
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorInputProtocol?
    var router: TodoListRouterProtocol?
    private var todos: [Todo] = []

    func viewDidLoad() {
        interactor?.fetchTodos()
    }

    func didTapAdd(title: String) {
        interactor?.addTodo(title: title)
    }

    func didToggle(at index: Int) {
        interactor?.toggleTodo(id: todos[index].id)
    }

    func didDelete(at index: Int) {
        interactor?.deleteTodo(id: todos[index].id)
    }

    func didSelect(at index: Int) {
        router?.openDetail(todoID: todos[index].id)
    }

    func didFetch(todos: [Todo]) {
        self.todos = todos
        view?.show(todos: todos)
    }
}
