import Foundation

final class TodoDetailViewModel {
    var onChange: (() -> Void)?

    private let store: TodoStore
    private let todoID: UUID
    private(set) var titleText = ""
    private(set) var statusText = ""
    private(set) var dateText = ""

    init(store: TodoStore, todoID: UUID) {
        self.store = store
        self.todoID = todoID
    }

    func load() {
        guard let todo = store.todo(id: todoID) else { return }
        titleText = todo.title
        statusText = TodoFormatting.status(todo.isCompleted)
        dateText = "Создана: \(TodoFormatting.date(todo.createdAt))"
        onChange?()
    }

    func toggle() {
        store.toggle(id: todoID)
        load()
    }
}

