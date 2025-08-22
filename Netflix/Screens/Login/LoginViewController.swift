import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        

        tableView.register(WelcomeCell.self, forCellReuseIdentifier: WelcomeCell.identifier)
        tableView.register(EmailCell.self, forCellReuseIdentifier: EmailCell.identifier)
        tableView.register(PasswordCell.self, forCellReuseIdentifier: PasswordCell.identifier)
        tableView.register(LoginButtonCell.self, forCellReuseIdentifier: LoginButtonCell.identifier)
        tableView.register(GoogleButtonCell.self, forCellReuseIdentifier: GoogleButtonCell.identifier)
        tableView.register(FooterCell.self, forCellReuseIdentifier: FooterCell.identifier)
        
    
        tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
    }
}


extension LoginViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.rows[indexPath.row]
        return tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
    }
}
