import Foundation

protocol TodoDetailViewProtocol: AnyObject {
    func show(title: String, status: String, date: String)
}

protocol TodoDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapToggle()
}

protocol TodoDetailInteractorInputProtocol: AnyObject {
    func fetch()
    func toggle()
}

protocol TodoDetailInteractorOutputProtocol: AnyObject {
    func didFetch(todo: Todo)
}

protocol TodoDetailRouterProtocol: AnyObject {}
