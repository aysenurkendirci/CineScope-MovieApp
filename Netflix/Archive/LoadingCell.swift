/*
import UIKit
import SnapKit

final class LoadingCell: UICollectionViewCell {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        activityIndicator.color = .white
        contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure() {
        activityIndicator.startAnimating()
    }
}*/
