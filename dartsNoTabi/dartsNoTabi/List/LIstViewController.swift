import Foundation
import UIKit

protocol ListDelegate: AnyObject {

    func didLoad()
}

protocol ListItemDataSource: AnyObject {
    
}

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: ListDelegate?
    var dataSource: ListTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.didLoad()
    }
}
