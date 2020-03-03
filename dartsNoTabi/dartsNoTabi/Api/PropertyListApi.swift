import Foundation

protocol PropertyListApiProtocol {

}

struct PropertyListApi: PropertyListApiProtocol {
    private let api: ApiProtocol
    init(apiTask: ApiProtocol = ApiTask()) {
        api = apiTask
    }
}
