import Foundation
import PromiseKit

typealias ListInteractorDependencies = (
)

protocol ListInteractorProtocol {
    
}

class ListInteractor: ListInteractorProtocol {

    private let dependencies: ListInteractorDependencies
    
    init(
        dependencies: ListInteractorDependencies = ()) {
        self.dependencies = dependencies
    }
}
