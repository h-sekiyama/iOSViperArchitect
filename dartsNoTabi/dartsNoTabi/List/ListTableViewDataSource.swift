import UIKit

class ListTableViewDataSource: NSObject {
    
    private var dataSource: ListItemDataSource
    
    init(dataSource: ListItemDataSource) {
        self.dataSource = dataSource
    }
    
    
}
