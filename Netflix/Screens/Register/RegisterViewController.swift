import UIKit

final class RegisterViewController: BaseCollectionViewController<RegisterRow> {
    
    internal let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rows = viewModel.rows
    }
    
    override func registerCells() {
        register([
            EmailCell.self,
            PasswordCell.self,
            RegisterButtonCell.self
        ])
    }
    //cellde butona basınca tetikleniyor
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        
        if let registerButtonCell = cell as? RegisterButtonCell {
            registerButtonCell.delegate = self
        }
        return cell
    }
}
