// MoodsCell.swift
/*
import UIKit
import SnapKit

struct MoodsCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: MoodsCell.self) }
    
    let moods: [String]
    let onMoodSelected: (String) -> Void
    
    func configure(cell: UICollectionViewCell) {
        (cell as? MoodsCell)?.configure(with: self)
    }
}
final class MoodsCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // ViewModel ile dışarıdan gelen tıklama olayını yakalamak için closure
    private var onMoodSelected: ((String) -> Void)?
    private var moods: [String] = []
    
    private let collectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MoodButtonCell.self, forCellWithReuseIdentifier: "MoodButtonCell")
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with viewModel: MoodsCellViewModel) {
        self.moods = viewModel.moods
        self.onMoodSelected = viewModel.onMoodSelected
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodButtonCell", for: indexPath) as! MoodButtonCell
        cell.configure(with: moods[indexPath.row])
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Buton genişliğini metin içeriğine göre dinamik olarak ayarla
        let moodText = moods[indexPath.row]
        let width = moodText.size(withAttributes: [.font: UIFont.systemFont(ofSize: 18)]).width + 30 // Padding ekle
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onMoodSelected?(moods[indexPath.row])
    }
}

// MoodsCell içindeki butonlar için küçük hücre
final class MoodButtonCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18)
        contentView.addSubview(titleLabel)
        
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(with mood: String) {
        titleLabel.text = mood
    }
 }*/
