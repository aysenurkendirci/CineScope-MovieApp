/*import UIKit
//her cell kendi modelini alıyor
protocol AnyConfigurableCell {
    func configureAny(with model: Any)
}

protocol ConfigurableCell: UICollectionViewCell, AnyConfigurableCell {
    associatedtype Model
    func configure(with model: Model)
}

extension ConfigurableCell {
    func configureAny(with model: Any) {
        if let typedModel = model as? Model {
            configure(with: typedModel)
        }
    }
}
*/
