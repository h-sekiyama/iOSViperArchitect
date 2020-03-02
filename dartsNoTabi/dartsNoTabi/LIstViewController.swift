import Foundation
import UIKit

protocol ListDelegate: AnyObject {
    func tekito()
    
    func didLoad()
}

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: ListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.didLoad()
        
        tableView.estimatedRowHeight = 190
    }
}
