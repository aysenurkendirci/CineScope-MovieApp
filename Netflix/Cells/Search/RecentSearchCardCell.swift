import UIKit
import SnapKit

struct RecentSearchCardVM: CellConfigurator {
    static var reuseId: String { String(describing: RecentSearchCardCell.self) }
    let id: Int
    let title: String
    let posterURL: String
    let overview: String
    var onTap: ((Int) -> Void)?

    func configure(cell: UICollectionViewCell) {
        (cell as? RecentSearchCardCell)?.configure(with: self)
    }
}

final class RecentSearchCardCell: UICollectionViewCell {
    private let poster = UIImageView()
    private let titleLabel = UILabel()
    private let overviewLabel = UILabel()
    private let moreButton = UIButton(type: .system)

    // Fade ve arka plan degrade
    private let fadeView = UIView()
    private let fadeLayer = CAGradientLayer()
    private let bgGradient = CAGradientLayer()

    private let netflixRed = UIColor(red: 0.90, green: 0.04, blue: 0.08, alpha: 1)

    private var movieId: Int?
    private var onTap: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init coder") }

    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
        titleLabel.text = nil
        overviewLabel.text = nil
        movieId = nil
        onTap = nil
    }

    private func setupUI() {
        // Kapsayıcı
        layer.cornerRadius = 16
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(white: 0.22, alpha: 1).cgColor

        // Bordo degrade arka plan
        bgGradient.colors = [
            UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1).cgColor,
            UIColor(red: 0.13, green: 0.00, blue: 0.00, alpha: 1).cgColor
        ]
        bgGradient.startPoint = CGPoint(x: 0, y: 0)
        bgGradient.endPoint = CGPoint(x: 1, y: 1)
        contentView.layer.insertSublayer(bgGradient, at: 0)

        // Görseller & metinler
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 12

        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1

        overviewLabel.font = .systemFont(ofSize: 13)
        overviewLabel.textColor = .systemGray2
        overviewLabel.numberOfLines = 2
        overviewLabel.lineBreakMode = .byTruncatingTail
        overviewLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        moreButton.setTitle("Devamını gör", for: .normal)
        moreButton.setTitleColor(netflixRed, for: .normal)
        moreButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        moreButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)

        let rightStack = UIStackView(arrangedSubviews: [titleLabel, overviewLabel, moreButton])
        rightStack.axis = .vertical
        rightStack.alignment = .fill
        rightStack.spacing = 6

        let hStack = UIStackView(arrangedSubviews: [poster, rightStack])
        hStack.axis = .horizontal
        hStack.spacing = 12
        hStack.alignment = .top
        contentView.addSubview(hStack)

        poster.snp.makeConstraints { make in
            make.width.equalTo(72); make.height.equalTo(96)
        }
        hStack.snp.makeConstraints { $0.edges.equalToSuperview().inset(12) }

        // Fade (overview sağ kenarı)
        fadeView.isUserInteractionEnabled = false
        fadeView.layer.addSublayer(fadeLayer)
        contentView.addSubview(fadeView)
        fadeView.snp.makeConstraints { make in
            make.trailing.equalTo(overviewLabel.snp.trailing)
            make.top.bottom.equalTo(overviewLabel)
            make.width.equalTo(42)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bgGradient.frame = contentView.bounds

        fadeLayer.frame = fadeView.bounds
        fadeLayer.startPoint = CGPoint(x: 0, y: 0.5)
        fadeLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        fadeLayer.colors     = [
            UIColor.clear.cgColor,
            UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1).cgColor
        ]
    }

    func configure(with vm: RecentSearchCardVM) {
        movieId = vm.id
        onTap   = vm.onTap
        titleLabel.text = vm.title

        let text = vm.overview.trimmingCharacters(in: .whitespacesAndNewlines)
        overviewLabel.text = text.isEmpty ? "Kısa özeti görmek için dokun." : text

        poster.setImage(from: vm.posterURL)
    }

    @objc private func didTap() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if let id = movieId { onTap?(id) }
    }
}

// Basit image loader
private let _imageCache = NSCache<NSString, UIImage>()
private extension UIImageView {
    func setImage(from urlString: String?, placeholder: UIImage? = nil) {
        self.image = placeholder
        guard let urlString, let url = URL(string: urlString) else { return }
        if let cached = _imageCache.object(forKey: urlString as NSString) {
            self.image = cached; return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data,_,_ in
            guard let self, let data, let img = UIImage(data: data) else { return }
            _imageCache.setObject(img, forKey: urlString as NSString)
            DispatchQueue.main.async { self.image = img }
        }.resume()
    }
}
