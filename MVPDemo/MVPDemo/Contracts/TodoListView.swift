import Foundation

protocol TodoListView: AnyObject {
    func display(todos: [Todo])
}

