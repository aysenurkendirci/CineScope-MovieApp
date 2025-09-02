import UIKit
import SnapKit

struct SearchHeaderViewModel {
    weak var delegate: UISearchBarDelegate?
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
