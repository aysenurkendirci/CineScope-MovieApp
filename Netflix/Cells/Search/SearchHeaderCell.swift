import UIKit
import SnapKit

struct SearchHeaderViewModel: CellConfigurator {
    static var reuseId: String { String(describing: SearchHeaderCell.self) }

    weak var delegate: UISearchBarDelegate?

    func configure(cell: UICollectionViewCell) {
        (cell as? SearchHeaderCell)?.configure(with: self)
    }
}
final class SearchHeaderCell: UICollectionViewCell {
    private let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    private func setupUI() {
        searchBar.placeholder = "Film ara"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()
        
        searchBar.searchTextField.backgroundColor = UIColor(white: 0.2, alpha: 1)
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Film ara",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.tintColor = .systemRed
        
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
    }
    
    func configure(with vm: SearchHeaderViewModel) {
        searchBar.delegate = vm.delegate
    }
}
