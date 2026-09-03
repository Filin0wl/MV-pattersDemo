import Foundation

protocol TodoListPresentationLogic {
    func presentTodos(response: TodoList.Fetch.Response)
}

final class TodoListPresenter: TodoListPresentationLogic {
    weak var viewController: TodoListDisplayLogic?

    func presentTodos(response: TodoList.Fetch.Response) {
        let items = response.todos.map { todo in
            TodoList.Fetch.ViewModel.Item(
                title: todo.title,
                date: TodoFormatting.date(todo.createdAt),
                isCompleted: todo.isCompleted
            )
        }
        viewController?.displayTodos(viewModel: TodoList.Fetch.ViewModel(items: items))
    }
}
