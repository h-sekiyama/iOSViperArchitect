import Foundation

struct PropertyListResponseDto {
    let item: [Item]
    
    struct Item: Codable {
        let bukkenNm: String?
        let kanigazoB: String?
    }
}
