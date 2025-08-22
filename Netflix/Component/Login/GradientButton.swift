import UIKit

final class GradientButton: UIButton {
    private let gradientLayer = CAGradientLayer()
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        gradientLayer.colors = [
            UIColor.systemRed.cgColor,
            UIColor.systemPink.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
