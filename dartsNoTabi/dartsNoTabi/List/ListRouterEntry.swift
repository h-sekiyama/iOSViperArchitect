import Foundation

class ListEntryEntity: NSObject {
    
}

protocol ListRouterEntry {
    func push(from: ViewControllerTransition, entry: ListEntryEntity)
}

class ListRouter: ListRouterEntry {
    func push(from: ViewControllerTransition, entry: ListEntryEntity) {
        let view = ListViewController()
        let presenter = ListPresenter(entry: entry,
                              view: view,
                              transition: view)
        view.delegate = presenter
        view.dataSource = ListTableViewDataSource(dataSource: presenter)
        from.push(view, animated: true)
    }
}
