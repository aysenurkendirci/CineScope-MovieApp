import UIKit

/// Ortak CollectionViewController
class BaseCollectionViewController: UIViewController,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegate {
    
    var collectionSections: [Section] = []
    let baseView = BaseView()
    
    var collectionView: UICollectionView {
         return baseView.collectionView
     }
    
    override func loadView() {
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.sectionsProvider = { [weak self] in
            self?.collectionSections ?? []
        }
        
        baseView.collectionView.dataSource = self
        baseView.collectionView.delegate = self
        
        registerCells()
    }
    
    /// Alt sınıfta override edilmeli
    func registerCells() {
        fatalError("registerCells() must be implemented in subclass")
    }
    
    /// Hücre kayıt kolaylığı
    func register(_ cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach {
            baseView.collectionView.register($0, forCellWithReuseIdentifier: String(describing: $0))
        }
    }
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        collectionSections[section].rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = collectionSections[indexPath.section].rows[indexPath.item]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: type(of: vm).reuseId,
            for: indexPath
        )
        vm.configure(cell: cell)
        return cell
    }
}
