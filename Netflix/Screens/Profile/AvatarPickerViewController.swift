import UIKit

final class AvatarPickerViewController: BaseCollectionViewController {

    var onSelect: ((URL) -> Void)?

    private var section = Section(layoutType: .grid3, rows: [])

    override func registerCells() {
        register([AvatarCell.self])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Avatar Seç"
        view.backgroundColor = .black

        Task {
            try? await RC.shared.ensureLoaded()
            let urls = (RC.shared.avatarURLs.isEmpty ? RC.shared.avatarURLsOrFallback : RC.shared.avatarURLs)
                .compactMap(URL.init(string:))
            section.rows = urls.map { AvatarCellViewModel(url: $0) }
            collectionSections = [section]
            baseView.collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vm = section.rows[indexPath.item] as? AvatarCellViewModel else { return }
        onSelect?(vm.url)
        navigationController?.popViewController(animated: true)
    }
}
