import UIKit

final class TodoDetailViewController: UIViewController {
    private let viewModel: TodoDetailViewModel
    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()

    init(viewModel: TodoDetailViewModel) {
        self.viewModel = viewModel
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
            primaryAction: UIAction { [weak self] _ in self?.viewModel.toggle() }
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
        viewModel.onChange = { [weak self] in
            guard let self else { return }
            self.titleLabel.text = self.viewModel.titleText
            self.statusLabel.text = self.viewModel.statusText
            self.dateLabel.text = self.viewModel.dateText
        }
        viewModel.load()
    }
}

