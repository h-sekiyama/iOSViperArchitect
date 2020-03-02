import Foundation
import UIKit

protocol ListDelegate: AnyObject {
    func tekito()
    
    func didLoad()
}

class ListViewController: UIViewController {

    var delegate: ListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.didLoad()
    }
}
