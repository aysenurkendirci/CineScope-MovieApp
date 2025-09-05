import UIKit
import SnapKit

final class BaseView: UIView {
    var sectionsProvider: (() -> [Section])?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let section = self?.sectionsProvider?()[sectionIndex] else { return nil }
            return BaseView.makeLayout(for: section.layoutType)
        }
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.alwaysBounceVertical = true            
        cv.contentInsetAdjustmentBehavior = .always
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private static func makeLayout(for type: SectionLayoutType) -> NSCollectionLayoutSection {
        switch type {
        case .vertical:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .estimated(100))
            )
            item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .estimated(100)),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 0)
            return section

        case .horizontal:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .absolute(140),
                                  heightDimension: .absolute(220))
            )
            item.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .absolute(220)),
                subitems: [item]
            )
            group.interItemSpacing = .fixed(12)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 16, leading: 8, bottom: 16, trailing: 8)
            return section

        case .grid2:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                  heightDimension: .estimated(250))
            )
            item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .estimated(250)),
                subitems: [item, item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 0)
            return section

        case .grid3: ///avatar için gridi 3 ledim ama gridleri ortaklıcam
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0/3.0),
                                  heightDimension: .fractionalWidth(1.0/3.0)) // kare
            )
            item.contentInsets = .init(top: 6, leading: 6, bottom: 6, trailing: 6)

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .fractionalWidth(1.0/3.0)),
                subitems: [item, item, item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 12, leading: 6, bottom: 12, trailing: 6)
            return section
        }
    }
}
