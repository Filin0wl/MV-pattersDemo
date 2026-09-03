import Foundation

protocol TodoDetailPresentationLogic {
    func presentTodo(response: TodoDetail.Fetch.Response)
}

final class TodoDetailPresenter: TodoDetailPresentationLogic {
    weak var viewController: TodoDetailDisplayLogic?

    func presentTodo(response: TodoDetail.Fetch.Response) {
        let todo = response.todo
        viewController?.displayTodo(
            viewModel: TodoDetail.Fetch.ViewModel(
                title: todo.title,
                status: TodoFormatting.status(todo.isCompleted),
                date: "Создана: \(TodoFormatting.date(todo.createdAt))"
            )
        )
    }
}
