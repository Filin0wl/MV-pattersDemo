import Foundation

/// MVP: вся логика в Presenter. View только рисует то, что ей передали.
final class TodoListPresenter {
    weak var view: TodoListView?
    private let store: TodoStore
    private var todos: [Todo] = []

    init(store: TodoStore) {
        self.store = store
    }

    func viewDidLoad() {
        refresh()
    }

    func add(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        store.add(title: trimmed)
        refresh()
    }

    func toggle(at index: Int) {
        store.toggle(id: todos[index].id)
        refresh()
    }

    func delete(at index: Int) {
        store.delete(id: todos[index].id)
        refresh()
    }

    func todoID(at index: Int) -> UUID {
        todos[index].id
    }

    private func refresh() {
        todos = store.fetchAll()
        view?.display(todos: todos)
    }
}

