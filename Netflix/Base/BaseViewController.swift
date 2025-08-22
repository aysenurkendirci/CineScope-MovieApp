import UIKit

// UICollectionViewDataSource ve UICollectionViewDelegateFlowLayout protokollerine uyum sağlar.
class BaseCollectionViewController<RowType>: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var mainCollectionView: UICollectionView {
        (view as! BaseView).collectionView
    }
    
    var rows: [RowType] = []

    override func loadView() {
        view = BaseView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Koleksiyon görünümünün dataSource ve delegate'i bu sınıfa atanır.
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    
    // MARK: - Ortak UICollectionViewDataSource Metotları
    
    // Satır sayısını viewModel'den gelen rows dizisine göre belirler.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows.count
    }
    
    // Bu metot, her alt sınıfta farklı olacağı için zorunlu olarak geçersiz kılınmalıdır.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("`cellForItemAt` must be overridden by a subclass.")
    }
    
    // MARK: - Ortak UICollectionViewDelegateFlowLayout Metotları
    
    // Her hücrenin boyutunu belirler ve ortak bir değer döndürür.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
}
