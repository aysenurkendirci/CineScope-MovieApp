import UIKit
import SnapKit
import WebKit

struct TrailerVideoViewModel {
    let trailerURL: String
}

final class TrailerVideoCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let webView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        titleLabel.text = "Fragman"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(webView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview().inset(12)
            make.height.equalTo(200)
        }
        
        webView.layer.cornerRadius = 12
        webView.clipsToBounds = true
    }
    
    func configure(with vm: TrailerVideoViewModel) {
        // YouTube linkini embed formatına çeviriyoruz
        if let url = URL(string: vm.trailerURL.replacingOccurrences(of: "watch?v=", with: "embed/")) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
