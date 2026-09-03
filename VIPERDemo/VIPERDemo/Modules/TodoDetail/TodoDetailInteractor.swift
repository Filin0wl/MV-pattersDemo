import Foundation

final class TodoDetailInteractor: TodoDetailInteractorInputProtocol {
    weak var presenter: TodoDetailInteractorOutputProtocol?
    private let store: TodoStore
    private let todoID: UUID

    init(store: TodoStore, todoID: UUID) {
        self.store = store
        self.todoID = todoID
    }

    func fetch() {
        guard let todo = store.todo(id: todoID) else { return }
        presenter?.didFetch(todo: todo)
    }

    func toggle() {
        store.toggle(id: todoID)
        fetch()
    }
}
