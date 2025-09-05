/*
import UIKit
import SnapKit


struct RecommendationTextCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: RecommendationTextCell.self) }
    
    let text: String
    let isLoading: Bool
    
    func configure(cell: UICollectionViewCell) {
        (cell as? RecommendationTextCell)?.configure(with: self)
    }
}
final class RecommendationTextCell: UICollectionViewCell {
    
    private let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .white
        textView.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        textView.isEditable = false
        textView.layer.cornerRadius = 10
        
        contentView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with viewModel: RecommendationTextCellViewModel) {
        textView.text = viewModel.text
    }
 }*/
