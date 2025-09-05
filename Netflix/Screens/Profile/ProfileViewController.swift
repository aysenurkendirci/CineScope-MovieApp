import UIKit

final class ProfileViewController: BaseCollectionViewController {

    private let viewModel = ProfileViewModel()
    private var infoSection = Section(layoutType: .vertical, rows: [])
    private var favoritesSection = Section(layoutType: .grid2, rows: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Profil"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(openSettings)
        )

        setupBindings()
        viewModel.loadProfile()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshFavorites),
            name: .favoritesUpdated,
            object: nil
        )
    }

    @objc private func openSettings() {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        vc.title = "Ayarlar"
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupBindings() {
        viewModel.onProfileLoaded = { [weak self] in
            self?.buildUI()
        }
    }

    private func buildUI() {
        infoSection.rows = []
        favoritesSection.rows = []

        if let p = viewModel.userProfile {
            let vm = ProfileInfoCellViewModel(
                email: p.email,
                avatarURL: p.avatarURL,
                delegate: self
            )
            infoSection.rows = [vm]
        }

        let favVMs = viewModel.favoriteMovies.map {
            MovieCellViewModel(id: $0.id,
                               title: $0.title,
                               posterURL: $0.posterURL,
                               year: nil)
        }
        favoritesSection.rows = favVMs

        collectionSections = [infoSection, favoritesSection]
        baseView.collectionView.reloadData()
    }

    @objc private func refreshFavorites() {
        viewModel.loadProfile()
    }

    override func registerCells() {
        register([
            ProfileInfoCell.self,
            MovieCell.self,
            AvatarCell.self
        ])
    }
}

extension ProfileViewController: ProfileInfoCellDelegate {
    func profileInfoCellDidTapAvatar(_ cell: ProfileInfoCell) {
        let picker = AvatarPickerViewController()
        picker.onSelect = { [weak self] url in
            self?.viewModel.updateAvatar(urlString: url.absoluteString)
        }
        navigationController?.pushViewController(picker, animated: true)
    }
}
