import UIKit

class BaseCollectionViewController<RowType>: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var mainCollectionView: UICollectionView {
        (view as! BaseCollectionView).collectionView
    }
    
    var rows: [RowType] = []

    override func loadView() {
        view = BaseCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Child VC must override cellForItemAt")
    }
    
    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 70)
    }
}
