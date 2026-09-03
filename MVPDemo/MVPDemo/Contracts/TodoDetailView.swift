import Foundation

protocol TodoDetailView: AnyObject {
    func display(title: String, status: String, date: String)
}

