/*import UIKit

extension HomeViewController: UICollectionViewDataSource {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalMovieSectionCell", for: indexPath) as! HorizontalMovieSectionCell
        
        switch indexPath.section {
        case 0: cell.configure(with: viewModel.popularMovies)
        case 1: cell.configure(with: viewModel.nowPlayingMovies)
        case 2: cell.configure(with: viewModel.upcomingMovies)
        default: break
        }
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "SectionHeader",
            for: indexPath) as! SectionHeader
        
        switch indexPath.section {
        case 0: header.titleLabel.text = "Popüler Filmler"
        case 1: header.titleLabel.text = "Yeni Çıkanlar"
        case 2: header.titleLabel.text = "Yakında Gelecek"
        default: break
        }
        
        return header
    }
  
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 240)
    }
}
 */
