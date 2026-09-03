import Foundation

protocol TodoDetailBusinessLogic {
    func fetchTodo(request: TodoDetail.Fetch.Request)
    func toggleTodo(request: TodoDetail.Toggle.Request)
}

protocol TodoDetailDataStore {
    var todoID: UUID? { get set }
}

final class TodoDetailInteractor: TodoDetailBusinessLogic, TodoDetailDataStore {
    var presenter: TodoDetailPresentationLogic?
    var worker: TodoDetailWorker
    var todoID: UUID?

    init(worker: TodoDetailWorker) {
        self.worker = worker
    }

    func fetchTodo(request: TodoDetail.Fetch.Request) {
        guard let todoID, let todo = worker.todo(id: todoID) else { return }
        presenter?.presentTodo(response: TodoDetail.Fetch.Response(todo: todo))
    }

    func toggleTodo(request: TodoDetail.Toggle.Request) {
        guard let todoID else { return }
        worker.toggle(id: todoID)
        fetchTodo(request: TodoDetail.Fetch.Request())
    }
}
