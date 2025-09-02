import UIKit

/// Hücre yapılandırma protokolü
protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UICollectionViewCell)
}

/// Cell identifier için ortak protokol
protocol RowIdentifiable {
    var identifier: String { get }
}

extension UICollectionViewCell: RowIdentifiable {
    var identifier: String { String(describing: type(of: self)) }
}

/// Bölüm layout tipleri
enum SectionLayoutType {
    case vertical
    case horizontal
    case grid2
}

/// Section modeli
struct Section {
    var layoutType: SectionLayoutType = .vertical
    var rows: [CellConfigurator] = []
}
