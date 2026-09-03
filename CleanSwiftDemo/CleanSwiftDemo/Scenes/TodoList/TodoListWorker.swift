import Foundation

final class TodoListWorker {
    private let store: TodoStore

    init(store: TodoStore) {
        self.store = store
    }

    func fetchAll() -> [Todo] {
        store.fetchAll()
    }

    func add(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        store.add(title: trimmed)
    }

    func toggle(id: UUID) {
        store.toggle(id: id)
    }

    func delete(id: UUID) {
        store.delete(id: id)
    }
}
