import UIKit

final class TodoDetailViewController: UIViewController {
    private let store: TodoStore
    private let todoID: UUID

    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()

    init(store: TodoStore, todoID: UUID) {
        self.store = store
        self.todoID = todoID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Детали"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Статус",
            primaryAction: UIAction { [weak self] _ in
                guard let self else { return }
                self.store.toggle(id: self.todoID)
                self.render()
            }
        )

        [titleLabel, statusLabel, dateLabel].forEach { label in
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        statusLabel.font = .preferredFont(forTextStyle: .headline)
        dateLabel.font = .preferredFont(forTextStyle: .subheadline)
        dateLabel.textColor = .secondaryLabel

        let stack = UIStackView(arrangedSubviews: [titleLabel, statusLabel, dateLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        render()
    }

    private func render() {
        guard let todo = store.todo(id: todoID) else { return }
        titleLabel.text = todo.title
        statusLabel.text = TodoFormatting.status(todo.isCompleted)
        dateLabel.text = "Создана: \(TodoFormatting.date(todo.createdAt))"
    }
}

