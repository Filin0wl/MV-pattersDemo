import UIKit

protocol TodoListDisplayLogic: AnyObject {
    func displayTodos(viewModel: TodoList.Fetch.ViewModel)
}

final class TodoListViewController: UIViewController, TodoListDisplayLogic {
    var interactor: TodoListBusinessLogic?
    var router: (NSObjectProtocol & TodoListRoutingLogic & TodoListDataPassing)?

    private var items: [TodoList.Fetch.ViewModel.Item] = []
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Задачи"
        navigationItem.prompt = "Clean Swift"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .add,
            primaryAction: UIAction { [weak self] _ in self?.presentAddAlert() }
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        interactor?.fetchTodos(request: TodoList.Fetch.Request())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchTodos(request: TodoList.Fetch.Request())
    }

    func displayTodos(viewModel: TodoList.Fetch.ViewModel) {
        items = viewModel.items
        tableView.reloadData()
    }

    private func presentAddAlert() {
        let alert = UIAlertController(
            title: "Новая задача",
            message: "Clean Swift: View → Interactor → Worker, Presenter готовит ViewModel",
            preferredStyle: .alert
        )
        alert.addTextField { $0.placeholder = "Название" }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            self?.interactor?.addTodo(request: TodoList.Add.Request(title: alert.textFields?.first?.text ?? ""))
        })
        present(alert, animated: true)
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        var content = UIListContentConfiguration.subtitleCell()
        content.text = item.title
        content.secondaryText = item.date
        cell.contentConfiguration = content
        cell.accessoryType = item.isCompleted ? .checkmark : .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.selectTodo(request: TodoList.Select.Request(index: indexPath.row))
        router?.routeToDetail()
    }

    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let item = items[indexPath.row]
        let action = UIContextualAction(style: .normal, title: item.isCompleted ? "Снять" : "Готово") { [weak self] _, _, done in
            self?.interactor?.toggleTodo(request: TodoList.Toggle.Request(index: indexPath.row))
            done(true)
        }
        action.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, done in
            self?.interactor?.deleteTodo(request: TodoList.Delete.Request(index: indexPath.row))
            done(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
