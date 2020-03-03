/// 物件一覧用物件APIリクエストDTO
struct PropertyListRequestDto: RequestDto {
    /// 物件種別
    let propertyType: PropertyType
    /// ページ番号
    let page: Int
    // 市区郡括り1+市区郡括り3コード [SC]
    let cities: [String]

    /// パラメータを返却します
    /// - returns : パラメータのタプル
    // swiftlint:disable cyclomatic_complexity
    func params() -> [(key: String, value: String)] {
        var params: [(key: String, value: String)] = []

        /* 固定パラメータ */
        // フォーマット
        params.append(("FORMAT", "1"))
        // カウント
        params.append(("CNT", "20"))
        // 画像取得フラグ
        params.append(("GAZO", "2"))
        // 外部システム区分
        ["00", "01", "02"].forEach {
            params.append(("GSK", $0))
        }

        /* 可変パラメータ */

        // ページ番号
        params.append(("P", String(page)))
        // 種別
        params.append(("SE", propertyType.rawValue))
        // 市区郡括り1+市区郡括り3コード
        cities.forEach {
            params.append(("SC", $0))
        }

        // VAMP項目
        params.append(("GIK", "1"))

        return params
    }
    // swiftlint:enable cyclomatic_complexity
}

private extension Bool {
    func toParam() -> String {
        return self == true ? "1" : "0"
    }
}
