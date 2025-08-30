import UIKit
import SnapKit

struct MovieCellViewModel {
    let movie: Movie
}

final class MovieCell: UICollectionViewCell {
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let yearLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 12
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        yearLabel.font = .systemFont(ofSize: 12, weight: .light)
        yearLabel.textColor = .lightGray
        
        let stack = UIStackView(arrangedSubviews: [posterImageView, titleLabel, yearLabel])
        stack.axis = .vertical
        stack.spacing = 4
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(180)
        }
    }
    func configure(with model: MovieCellViewModel) {
        titleLabel.text = model.movie.title
        yearLabel.text = model.movie.year
        
        if let urlString = model.movie.posterURL, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                }
            }.resume()
        } else {
            posterImageView.image = nil
            posterImageView.backgroundColor = .red
        }
    }
}
