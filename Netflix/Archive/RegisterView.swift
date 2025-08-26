/*import UIKit
import SnapKit

final class RegisterView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        registerCells()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        collectionView.backgroundColor = .white
    }
    
    private func registerCells() {
        collectionView.register(EmailCell.self, forCellWithReuseIdentifier: EmailCell.identifier)
        collectionView.register(PasswordCell.self, forCellWithReuseIdentifier: PasswordCell.identifier)
        collectionView.register(RegisterButtonCell.self, forCellWithReuseIdentifier: RegisterButtonCell.identifier)
    }
}
*/
