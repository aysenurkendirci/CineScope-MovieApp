import UIKit

final class LoginViewController: BaseCollectionViewController<LoginRow> {
    
    internal let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rows = viewModel.rows
    }
    
    override func registerCells() { //cell tipleri overridee
        register([
            WelcomeCell.self,
            EmailCell.self,
            PasswordCell.self,
            LoginButtonCell.self,
            GoogleButtonCell.self,
            FooterCell.self
        ])
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        
        if let footerCell = cell as? FooterCell {
            footerCell.delegate = self
        }
        return cell
    }
}

