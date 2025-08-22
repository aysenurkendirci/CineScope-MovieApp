import UIKit
import SnapKit

protocol BaseView {
    var collectionView: UICollectionView { get }
}

final class DefaultBaseView: UIView, BaseView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0 //gücreler arası boşluk bırakılmayacak
        return UICollectionView(frame: .zero, collectionViewLayout: layout) //Başlangıçta çerçevesiz  SnapKit ile constraint ekleniyor
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() } //SnapKit ile collectionView tüm kenarları kaplayacak şekilde parent view’e sabitleniyor
        collectionView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
