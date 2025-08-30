import UIKit
import SnapKit

protocol RowIdentifiable {
    var identifier: String { get }
}

extension UICollectionViewCell: RowIdentifiable {
    var identifier: String { String(describing: type(of: self)) } //string otomotik
}
enum SectionLayoutType {
    case vertical
    case horizontal
}

class BaseCollectionViewController: UIViewController,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegate {

    var collectionSections: [Section] = []

    //section indexil layout atıyoruz reuse  mantığı
    lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.makeLayout(for: sectionIndex) //closure her sectionn indexine göre çizilicek ops değil
        }
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCells()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func registerCells() {
        fatalError("registerCells() must be implemented in subclass")
    }
    // _ parametre zorunluluğu kaldırılamıs için
    func register(_ cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach {
            collectionView.register($0, forCellWithReuseIdentifier: String(describing: $0))
        }
    }
    
    private func makeLayout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = collectionSections[sectionIndex]

        switch section.layoutType {
        case .vertical:
            let item = NSCollectionLayoutItem(///boyutu
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0), ///hücre genişliği ekranın tamamı
                    heightDimension: .estimated(100) ///yükseklik
                )
            )

            let group = NSCollectionLayoutGroup.vertical( ///itemlerin grubu
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(100)
                ),
                subitems: [item]
            )

            let section = NSCollectionLayoutSection(group: group) ///boyut,item birleşimi
            section.interGroupSpacing = 16
            return section

        case .horizontal:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(140),
                    heightDimension: .absolute(220)
                )
            )

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(220) 
                ),
                subitems: [item]
            )
            group.interItemSpacing = .fixed(12)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section


        case .none:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(1)
                )
            )

            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(1)
                ),
                subitems: [item]
            )

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            return section
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionSections.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        collectionSections[section].rows?.count ?? 0 //satırın row sayısını döndürür ? boş olabiliceği için
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = collectionSections[indexPath.section].rows?[indexPath.item]
//Data source
        if let cell = row as? UICollectionViewCell {
            return cell
        }

        if let vm = row as? WelcomeCellViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: WelcomeCell.self),
                for: indexPath
            ) as! WelcomeCell
            cell.configure(with: vm)
            return cell
        }

        if let vm = row as? InputCellViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: InputCell.self),
                for: indexPath
            ) as! InputCell
            cell.configure(with: vm)
            return cell
        }

        if let vm = row as? ButtonCellViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ButtonCell.self),
                for: indexPath
            ) as! ButtonCell
            cell.configure(with: vm)
            return cell
        }

        if let vm = row as? FooterCellViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: FooterCell.self),
                for: indexPath
            ) as! FooterCell
            cell.configure(with: vm)
            return cell
        }

        if let vm = row as? MovieCellViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: MovieCell.self),
                for: indexPath
            ) as! MovieCell
            cell.configure(with: vm)
            return cell
        }
        
        if let vm = row as? MovieSectionViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: MovieSectionCell.self),
                for: indexPath
            ) as! MovieSectionCell
            cell.configure(with: vm)
            return cell
        }
        if let vm = row as? TrailerHeaderViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: TrailerHeaderCell.self),
                for: indexPath
            ) as! TrailerHeaderCell
            cell.configure(with: vm)
            return cell
        }

        if let vm = row as? TrailerRatingViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: TrailerRatingCell.self),
                for: indexPath
            ) as! TrailerRatingCell
            cell.configure(with: vm)
            return cell
        }

        if let vm = row as? TrailerCastViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: TrailerCastCell.self),
                for: indexPath
            ) as! TrailerCastCell
            cell.configure(with: vm)
            return cell
        }

        if let vm = row as? TrailerVideoViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: TrailerVideoCell.self),
                for: indexPath
            ) as! TrailerVideoCell
            cell.configure(with: vm)
            return cell
        }


        return UICollectionViewCell()
    }
}
