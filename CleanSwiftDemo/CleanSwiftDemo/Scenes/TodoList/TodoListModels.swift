import Foundation

enum TodoList {
    enum Fetch {
        struct Request {}

        struct Response {
            let todos: [Todo]
        }

        struct ViewModel {
            struct Item {
                let title: String
                let date: String
                let isCompleted: Bool
            }

            let items: [Item]
        }
    }

    enum Add {
        struct Request {
            let title: String
        }
    }

    enum Toggle {
        struct Request {
            let index: Int
        }
    }

    enum Delete {
        struct Request {
            let index: Int
        }
    }

    enum Select {
        struct Request {
            let index: Int
        }
    }
}
