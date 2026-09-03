import Foundation

final class TodoDetailPresenter {
    weak var view: TodoDetailView?
    private let store: TodoStore
    private let todoID: UUID

    init(store: TodoStore, todoID: UUID) {
        self.store = store
        self.todoID = todoID
    }

    func viewDidLoad() {
        render()
    }

    func toggle() {
        store.toggle(id: todoID)
        render()
    }

    private func render() {
        guard let todo = store.todo(id: todoID) else { return }
        view?.display(
            title: todo.title,
            status: TodoFormatting.status(todo.isCompleted),
            date: "Создана: \(TodoFormatting.date(todo.createdAt))"
        )
    }
}

