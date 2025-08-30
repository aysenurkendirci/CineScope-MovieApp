import UIKit
import SnapKit

struct ButtonCellViewModel {
    var title: String
    var titleColor: UIColor
    var gradientColors: [UIColor]?
    var borderColor: UIColor? = nil
    var borderWidth: CGFloat = 0
    var cornerRadius: CGFloat = 8
    var onTap: (() -> Void)?
}

final class ButtonCell: UICollectionViewCell {
    private let button = UIButton(type: .custom)
    private let gradientLayer = CAGradientLayer()
    private var handler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(button)
        button.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)   // üst/alt 8
            $0.leading.trailing.equalToSuperview().inset(16) // yanlarda 16
        }

        
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configure(with model: ButtonCellViewModel) {
        button.setTitle(model.title, for: .normal)
        button.setTitleColor(model.titleColor, for: .normal)
        button.layer.cornerRadius = model.cornerRadius
        
        // Eğer gradient verilmişse uygula
        if let colors = model.gradientColors {
            gradientLayer.isHidden = false
            gradientLayer.colors = colors.map { $0.cgColor }
            button.backgroundColor = .clear
        } else {
            gradientLayer.isHidden = true
            button.backgroundColor = .white
        }
        
        // Border (Google Login gibi butonlarda)
        if let borderColor = model.borderColor {
            button.layer.borderColor = borderColor.cgColor
            button.layer.borderWidth = model.borderWidth
        } else {
            button.layer.borderWidth = 0
        }
        
        handler = model.onTap
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = button.bounds
    }
    
    @objc private func didTap() {
        print("Button tapped:", button.currentTitle ?? "")
        handler?()
    }
}
