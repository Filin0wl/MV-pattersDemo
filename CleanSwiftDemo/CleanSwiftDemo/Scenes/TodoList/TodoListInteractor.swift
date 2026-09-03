import Foundation

protocol TodoListBusinessLogic {
    func fetchTodos(request: TodoList.Fetch.Request)
    func addTodo(request: TodoList.Add.Request)
    func toggleTodo(request: TodoList.Toggle.Request)
    func deleteTodo(request: TodoList.Delete.Request)
    func selectTodo(request: TodoList.Select.Request)
}

protocol TodoListDataStore {
    var selectedTodoID: UUID? { get set }
}

final class TodoListInteractor: TodoListBusinessLogic, TodoListDataStore {
    var presenter: TodoListPresentationLogic?
    var worker: TodoListWorker
    var selectedTodoID: UUID?

    private var todos: [Todo] = []

    init(worker: TodoListWorker) {
        self.worker = worker
    }

    func fetchTodos(request: TodoList.Fetch.Request) {
        todos = worker.fetchAll()
        presenter?.presentTodos(response: TodoList.Fetch.Response(todos: todos))
    }

    func addTodo(request: TodoList.Add.Request) {
        worker.add(title: request.title)
        fetchTodos(request: TodoList.Fetch.Request())
    }

    func toggleTodo(request: TodoList.Toggle.Request) {
        worker.toggle(id: todos[request.index].id)
        fetchTodos(request: TodoList.Fetch.Request())
    }

    func deleteTodo(request: TodoList.Delete.Request) {
        worker.delete(id: todos[request.index].id)
        fetchTodos(request: TodoList.Fetch.Request())
    }

    func selectTodo(request: TodoList.Select.Request) {
        selectedTodoID = todos[request.index].id
    }
}
