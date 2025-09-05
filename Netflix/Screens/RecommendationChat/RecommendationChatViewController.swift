import UIKit
import SnapKit

final class RecommendationChatViewController: BaseCollectionViewController {


    private let viewModel = RecommendationChatViewModel()
    private var messagesSection = Section(layoutType: .vertical, rows: [])
    private var categorySections: [Section] = []

    private let inputContainer = UIView()
    private let inputField = UITextField()
    private let sendButton = UIButton(type: .system)
    private var inputBottom: Constraint?

    private let moodBar = UIView()
    private let moodStack = UIStackView()
    private let moods = ["Neşeli", "Üzgün", "Korku", "Romantik", "Heyecanlı"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Asistan"
        view.backgroundColor = .black

        setupBindings()
        setupInputBar()
        setupMoodBar()

        viewModel.bootstrapIfNeeded()
        buildUI()


        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbChange(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        baseView.collectionView.addGestureRecognizer(tap)
    }

    private func setupBindings() {
        viewModel.onUpdate = { [weak self] in self?.buildUI() }
        viewModel.onError = { [weak self] msg in self?.showError(msg) }
        viewModel.onOpenTrailer = { [weak self] movieId in
            guard let self else { return }
            let vc = TrailerViewController(movieId: movieId)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func buildUI() {
 
        messagesSection.rows = viewModel.uiRows()


        categorySections = viewModel.categories.map { cat in
            var s = Section(layoutType: .vertical, rows: [])
            s.rows.append(MovieSectionViewModel(title: cat.title, movies: cat.movies))
            return s
        }

        collectionSections = [messagesSection] + categorySections
        baseView.collectionView.reloadData()
        scrollToBottom(animated: true)
    }

    private func showError(_ text: String) {
        messagesSection.rows.append(
            MessageCellViewModel(text: "Hata: \(text)", isUser: false) as any CellConfigurator
        )
        baseView.collectionView.reloadData()
        scrollToBottom(animated: true)
    }

    private func scrollToBottom(animated: Bool) {
        guard !collectionSections.isEmpty else { return }
        let lastSection = collectionSections.count - 1
        guard !collectionSections[lastSection].rows.isEmpty else { return }
        let lastRow = collectionSections[lastSection].rows.count - 1
        baseView.collectionView.scrollToItem(
            at: IndexPath(item: lastRow, section: lastSection),
            at: .bottom,
            animated: animated
        )
    }

    private func setupMoodBar() {
        view.addSubview(moodBar)
        moodBar.backgroundColor = .clear
        moodBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalTo(inputContainer.snp.top)
        }

        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        moodBar.addSubview(scroll)
        scroll.snp.makeConstraints { $0.edges.equalToSuperview() }

        moodStack.axis = .horizontal
        moodStack.alignment = .fill
        moodStack.spacing = 8
        scroll.addSubview(moodStack)
        moodStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
        }

        moods.forEach { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(white: 0.18, alpha: 1)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
            button.layer.cornerRadius = 16
            button.addTarget(self, action: #selector(didTapMoodButton(_:)), for: .touchUpInside)
            moodStack.addArrangedSubview(button)
        }
    }

    @objc private func didTapMoodButton(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        viewModel.send(title.lowercased())
    }

    private func setupInputBar() {
        view.addSubview(inputContainer)
        inputContainer.backgroundColor = UIColor(white: 0.08, alpha: 1)
        inputContainer.snp.makeConstraints { make in
            inputBottom = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
        }

        inputField.placeholder = "Bir film veya ruh halini yaz..."
        inputField.textColor = .white
        inputField.keyboardAppearance = .dark
        inputField.returnKeyType = .send
        inputField.addTarget(self, action: #selector(returnKeySend), for: .editingDidEndOnExit)

        sendButton.setTitle("Gönder", for: .normal)
        sendButton.tintColor = .systemBlue
        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)

        inputContainer.addSubview(inputField)
        inputContainer.addSubview(sendButton)

        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
        inputField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
        }

        baseView.collectionView.contentInset.bottom = 52 + 40 + 8
        baseView.collectionView.verticalScrollIndicatorInsets.bottom = 52 + 40
    }

    @objc private func didTapSend() {
        let text = inputField.text ?? ""
        inputField.text = nil
        viewModel.send(text)
        dismissKeyboard()
    }

    @objc private func returnKeySend() { didTapSend() }

    @objc private func dismissKeyboard() { view.endEditing(true) }

    @objc private func kbChange(_ noti: Notification) {
        guard
            let userInfo = noti.userInfo,
            let end = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let intersects = view.convert(end, from: nil).intersects(view.bounds)
        let bottom = intersects ? end.height - view.safeAreaInsets.bottom : 0
        inputBottom?.update(offset: -bottom)

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: curveRaw << 16),
                       animations: {
            self.view.layoutIfNeeded()
            self.baseView.collectionView.contentInset.bottom = 52 + 40 + bottom + 8
            self.baseView.collectionView.verticalScrollIndicatorInsets.bottom = 52 + 40 + bottom
        }, completion: { _ in
            self.scrollToBottom(animated: false)
        })
    }

    override func registerCells() {
        register([
            MessageCell.self,
            LoadingCell.self,
            MovieSectionCell.self,
            MovieCell.self
        ])
    }
}
