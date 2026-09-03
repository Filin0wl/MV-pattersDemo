import UIKit

@objc protocol TodoDetailRoutingLogic {}

protocol TodoDetailDataPassing {
    var dataStore: TodoDetailDataStore? { get }
}

final class TodoDetailRouter: NSObject, TodoDetailRoutingLogic, TodoDetailDataPassing {
    weak var viewController: TodoDetailViewController?
    var dataStore: TodoDetailDataStore?
}
