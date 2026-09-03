import UIKit

final class TodoListViewController: UIViewController, TodoListViewProtocol {
    var presenter: TodoListPresenterProtocol?
    private var todos: [Todo] = []
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Задачи"
        navigationItem.prompt = "VIPER"
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
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }

    func show(todos: [Todo]) {
        self.todos = todos
        tableView.reloadData()
    }

    private func presentAddAlert() {
        let alert = UIAlertController(
            title: "Новая задача",
            message: "VIPER: View → Presenter → Interactor, навигация через Router",
            preferredStyle: .alert
        )
        alert.addTextField { $0.placeholder = "Название" }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            self?.presenter?.didTapAdd(title: alert.textFields?.first?.text ?? "")
        })
        present(alert, animated: true)
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todos[indexPath.row]
        var content = UIListContentConfiguration.subtitleCell()
        content.text = todo.title
        content.secondaryText = TodoFormatting.date(todo.createdAt)
        cell.contentConfiguration = content
        cell.accessoryType = todo.isCompleted ? .checkmark : .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelect(at: indexPath.row)
    }

    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let todo = todos[indexPath.row]
        let action = UIContextualAction(style: .normal, title: todo.isCompleted ? "Снять" : "Готово") { [weak self] _, _, done in
            self?.presenter?.didToggle(at: indexPath.row)
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
            self?.presenter?.didDelete(at: indexPath.row)
            done(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
