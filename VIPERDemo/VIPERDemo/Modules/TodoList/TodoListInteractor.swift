import Foundation

final class TodoListInteractor: TodoListInteractorInputProtocol {
    weak var presenter: TodoListInteractorOutputProtocol?
    private let store: TodoStore

    init(store: TodoStore) {
        self.store = store
    }

    func fetchTodos() {
        presenter?.didFetch(todos: store.fetchAll())
    }

    func addTodo(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        store.add(title: trimmed)
        fetchTodos()
    }

    func toggleTodo(id: UUID) {
        store.toggle(id: id)
        fetchTodos()
    }

    func deleteTodo(id: UUID) {
        store.delete(id: id)
        fetchTodos()
    }
}
