import UIKit
import SnapKit

struct TrailerHeaderViewModel {
    let posterURL: String
    let title: String
    let overview: String
}

final class TrailerHeaderCell: UICollectionViewCell {
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let overviewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 12
        
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        overviewLabel.font = .systemFont(ofSize: 16, weight: .regular)
        overviewLabel.textColor = .lightGray
        overviewLabel.numberOfLines = 0
        overviewLabel.lineBreakMode = .byWordWrapping
        
        let stack = UIStackView(arrangedSubviews: [posterImageView, titleLabel, overviewLabel])
        stack.axis = .vertical
        stack.spacing = 10
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(240)
        }
    }
    
    func configure(with vm: TrailerHeaderViewModel) {
        titleLabel.text = vm.title
        overviewLabel.text = vm.overview
        
        if let url = URL(string: vm.posterURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
