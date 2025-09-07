import UIKit
import SDWebImage

final class AvatarPickerViewController: BaseCollectionViewController {

    var onSelect: ((URL) -> Void)?

    // Yatay şerit
    private var section = Section(layoutType: .avatarStrip, rows: [])

    override func registerCells() { register([AvatarCell.self]) }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Avatar Seç"
        view.backgroundColor = .systemBackground

        Task {
            try? await RC.shared.ensureLoaded()

            // RC → sadece http/https
            var urls = RC.shared.avatarURLs
                .filter { $0.hasPrefix("http://") || $0.hasPrefix("https://") }
                .compactMap(URL.init(string:))

            // RC boşsa RoboHash kedileri (36 adet)
            if urls.isEmpty {
                urls = (1...36).compactMap {
                    URL(string: "https://robohash.org/kitty-\($0)?set=set4&size=240x240&bgset=bg2")
                }
            }

            section.rows = urls.map { AvatarCellViewModel(url: $0) }
            collectionSections = [section]
            baseView.collectionView.reloadData()
            SDWebImagePrefetcher.shared.prefetchURLs(urls)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vm = section.rows[indexPath.item] as? AvatarCellViewModel else { return }
        onSelect?(vm.url)
        navigationController?.popViewController(animated: true)
    }
}
