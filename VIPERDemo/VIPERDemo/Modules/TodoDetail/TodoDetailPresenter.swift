import Foundation

final class TodoDetailPresenter: TodoDetailPresenterProtocol, TodoDetailInteractorOutputProtocol {
    weak var view: TodoDetailViewProtocol?
    var interactor: TodoDetailInteractorInputProtocol?
    var router: TodoDetailRouterProtocol?

    func viewDidLoad() {
        interactor?.fetch()
    }

    func didTapToggle() {
        interactor?.toggle()
    }

    func didFetch(todo: Todo) {
        view?.show(
            title: todo.title,
            status: TodoFormatting.status(todo.isCompleted),
            date: "Создана: \(TodoFormatting.date(todo.createdAt))"
        )
    }
}
