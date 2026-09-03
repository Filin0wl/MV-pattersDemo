import UIKit

final class TodoListViewController: UIViewController {
    private let viewModel: TodoListViewModel
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Задачи"
        navigationItem.prompt = "MVVM"
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
        viewModel.onChange = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.load()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }

    private func presentAddAlert() {
        let alert = UIAlertController(title: "Новая задача", message: "MVVM: View только биндится к ViewModel", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Название" }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            self?.viewModel.add(title: alert.textFields?.first?.text ?? "")
        })
        present(alert, animated: true)
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = viewModel.todos[indexPath.row]
        var content = UIListContentConfiguration.subtitleCell()
        content.text = todo.title
        content.secondaryText = TodoFormatting.date(todo.createdAt)
        if todo.isCompleted { content.textProperties.color = .secondaryLabel }
        cell.contentConfiguration = content
        cell.accessoryType = todo.isCompleted ? .checkmark : .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = TodoDetailViewController(viewModel: viewModel.detailViewModel(at: indexPath.row))
        navigationController?.pushViewController(detail, animated: true)
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todo = viewModel.todos[indexPath.row]
        let action = UIContextualAction(style: .normal, title: todo.isCompleted ? "Снять" : "Готово") { [weak self] _, _, done in
            self?.viewModel.toggle(at: indexPath.row)
            done(true)
        }
        action.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, done in
            self?.viewModel.delete(at: indexPath.row)
            done(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

