import Foundation
import PromiseKit

/// Api通信エラーコード
@objc
public enum ApiError: Int, Error {
    case recieveNilResponse = 0,    // レスポンスエラー
    recieveErrorHttpStatus,         // HTTPステータス
    recieveNilBody,                 // nilデータ
    failedParse,                    // パースエラー
    convertTags                     // タグコンバートエラー
}

public enum ApiMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol RequestDto {
    func params() -> [(key: String, value: String)]
}

protocol ApiProtocol {
    func request(apiMethod: ApiMethod, url: String, dto: RequestDto, convertTags: Bool) -> Promise<Data>
}

open class ApiTask: ApiProtocol {
    
    public var httpHeader: [String: String]? = ["content-type": "application/x-www-form-urlencoded"]
    
    public var timeoutInterval: TimeInterval = 60
    
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    
    static let apiTaskSession: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    public init() {}
    
    public func request(apiMethod: ApiMethod, url: String, dto: RequestDto, convertTags isConvert: Bool = true) -> Promise<Data> {
        return Promise<Data> { seal in
            let urlRequest = ApiTaskURLCreator.createRequest(apiMethod: apiMethod,
                                                             url: url,
                                                             dto: dto,
                                                             header: httpHeader,
                                                             timeoutInterval: timeoutInterval,
                                                             cachePolicy: cachePolicy)
            let task = ApiTask.apiTaskSession.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
                #if DEBUG
                    //self.debugUrlResponse(with: urlRequest, data: data, response: response)
                #endif

                if let error = error {
                    seal.reject(error)
                    return
                }
                if let responseError = ApiTask.check(response: response) {
                    seal.reject(responseError)
                    return
                }

                guard let data = data else {
                    seal.reject(ApiError.recieveNilBody)
                    return
                }

                if isConvert {
                    guard let data = self.convertTags(data) else {
                        let error = ApiError.convertTags
                        self.sendError(error as NSError)
                        seal.reject(error)
                        return
                    }
                    seal.fulfill(data)
                } else {
                    seal.fulfill(data)
                }
            })
            task.resume()
        }
    }
    
    static internal func check(response: URLResponse?) -> NSError? {
        guard let notNilResponse = response else {
            return createError(.recieveNilResponse, nil)
        }

        let httpResponse = notNilResponse as! HTTPURLResponse
        guard (200..<300) ~= httpResponse.statusCode else {
            return createError(.recieveErrorHttpStatus, ["statusCode": httpResponse.statusCode])
        }
        return nil
    }
    
    internal func convertTags(_ data: Data) -> Data? {
        guard var str = String(data: data, encoding: .utf8) else {
            return nil
        }
        str = replaceSup2(str)
        str = replaceBr(str)
        str = replaceSmall(str)
        return str.data(using: .utf8)
    }
    
    private func sendError(_ error: NSError) {
        #if DEBUG
            print("**** タグ変換エラー ****:  \(error)")
        #endif
    }
    
    static func createError(_ code: ApiError, _ info: [String: Any]?) -> NSError {
        return NSError(domain: "ApiError", code: code.rawValue, userInfo: info)
    }
    
    internal func replaceSup2(_ str: String) -> String {
        let pattern = "(?i)m<sup\\s*>2</sup\\s*>"
        let replace = "㎡"
        return  str.replacingOccurrences(of: pattern, with: replace, options: .regularExpression, range: nil)
    }

    internal func replaceBr(_ str: String) -> String {
        let pattern = "(?i)<br( )*(\\/|/)?>"
        let replace = "\\\\n"
        return  str.replacingOccurrences(of: pattern, with: replace, options: .regularExpression, range: nil)
    }

    internal func replaceSmall(_ str: String) -> String {
        let pattern = "(?i)<(\\\\)?/?small( )*(\\\\/|/)?>"
        let replace = ""
        return  str.replacingOccurrences(of: pattern, with: replace, options: .regularExpression, range: nil)
    }
}
