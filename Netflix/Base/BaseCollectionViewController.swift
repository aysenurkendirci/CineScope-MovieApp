import UIKit
import SnapKit

protocol RowIdentifiable {  //rowdaki her hücre için identifier zorunlu
    var identifier: String { get }
}

class BaseCollectionViewController<RowType: RowIdentifiable>: UIViewController,
                                                              UICollectionViewDataSource,
                                                              UICollectionViewDelegateFlowLayout {
    
    var rows: [RowType] = []
//subclass ana controllerdaki özel hücreler
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() } //tüm ekranı kaplaasın
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        registerCells() //subclass override
    }
    
    // Subclass override, her ekran kendi hücresin override etsin
    func registerCells() {
        fatalError("registerCells() must be implemented in subclass")
    }
    
    func register(_ cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach { cellType in
            collectionView.register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
        }//birden fazla celli ata
    }
    //datasource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = rows[indexPath.item]
        return collectionView.dequeueReusableCell(withReuseIdentifier: row.identifier, for: indexPath)
    }

    //isterse subclas override eder sabitilk için
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 70)
    }
}
