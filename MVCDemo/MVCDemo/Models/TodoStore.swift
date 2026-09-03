import Foundation

final class TodoStore {
    private var todos: [Todo]

    init(seed: [Todo]? = nil) {
        todos = seed ?? [
            Todo(
                id: UUID(),
                title: "Разобрать слои выбранного паттерна",
                isCompleted: true,
                createdAt: Date().addingTimeInterval(-86_400)
            ),
            Todo(
                id: UUID(),
                title: "Собрать приложение в симуляторе",
                isCompleted: false,
                createdAt: Date().addingTimeInterval(-3_600)
            ),
            Todo(
                id: UUID(),
                title: "Добавить свою задачу",
                isCompleted: false,
                createdAt: Date()
            )
        ]
    }

    func fetchAll() -> [Todo] {
        todos.sorted { $0.createdAt > $1.createdAt }
    }

    func todo(id: UUID) -> Todo? {
        todos.first { $0.id == id }
    }

    @discardableResult
    func add(title: String) -> Todo {
        let todo = Todo(id: UUID(), title: title, isCompleted: false, createdAt: Date())
        todos.append(todo)
        return todo
    }

    func toggle(id: UUID) {
        guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
        todos[index].isCompleted.toggle()
    }

    func delete(id: UUID) {
        todos.removeAll { $0.id == id }
    }
}

