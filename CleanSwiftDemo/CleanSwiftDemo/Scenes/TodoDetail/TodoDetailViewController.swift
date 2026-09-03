import UIKit

protocol TodoDetailDisplayLogic: AnyObject {
    func displayTodo(viewModel: TodoDetail.Fetch.ViewModel)
}

final class TodoDetailViewController: UIViewController, TodoDetailDisplayLogic {
    var interactor: TodoDetailBusinessLogic?
    var router: (NSObjectProtocol & TodoDetailRoutingLogic & TodoDetailDataPassing)?

    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Детали"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Статус",
            primaryAction: UIAction { [weak self] _ in
                self?.interactor?.toggleTodo(request: TodoDetail.Toggle.Request())
            }
        )

        [titleLabel, statusLabel, dateLabel].forEach { $0.numberOfLines = 0 }
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
        interactor?.fetchTodo(request: TodoDetail.Fetch.Request())
    }

    func displayTodo(viewModel: TodoDetail.Fetch.ViewModel) {
        titleLabel.text = viewModel.title
        statusLabel.text = viewModel.status
        dateLabel.text = viewModel.date
    }
}
