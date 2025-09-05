import UIKit

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UICollectionViewCell)
}
protocol RowIdentifiable {
    var identifier: String { get }
}
extension UICollectionViewCell: RowIdentifiable {
    var identifier: String { String(describing: type(of: self)) }
}
enum SectionLayoutType {
    case vertical
    case horizontal
    case grid2
    case grid3     
}

struct Section {
    var layoutType: SectionLayoutType = .vertical
    var rows: [CellConfigurator] = []
}
