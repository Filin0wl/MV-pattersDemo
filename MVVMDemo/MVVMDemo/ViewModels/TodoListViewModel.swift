import Foundation

/// MVVM: ViewModel держит состояние и сообщает View через замыкание `onChange`.
final class TodoListViewModel {
    var onChange: (() -> Void)?

    private let store: TodoStore
    private(set) var todos: [Todo] = []

    init(store: TodoStore) {
        self.store = store
    }

    func load() {
        todos = store.fetchAll()
        onChange?()
    }

    func add(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        store.add(title: trimmed)
        load()
    }

    func toggle(at index: Int) {
        store.toggle(id: todos[index].id)
        load()
    }

    func delete(at index: Int) {
        store.delete(id: todos[index].id)
        load()
    }

    func detailViewModel(at index: Int) -> TodoDetailViewModel {
        TodoDetailViewModel(store: store, todoID: todos[index].id)
    }
}

