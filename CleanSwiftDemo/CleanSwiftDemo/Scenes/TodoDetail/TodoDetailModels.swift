import Foundation

enum TodoDetail {
    enum Fetch {
        struct Request {}

        struct Response {
            let todo: Todo
        }

        struct ViewModel {
            let title: String
            let status: String
            let date: String
        }
    }

    enum Toggle {
        struct Request {}
    }
}
