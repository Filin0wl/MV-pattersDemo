import Foundation

final class TodoDetailWorker {
    private let store: TodoStore

    init(store: TodoStore) {
        self.store = store
    }

    func todo(id: UUID) -> Todo? {
        store.todo(id: id)
    }

    func toggle(id: UUID) {
        store.toggle(id: id)
    }
}
