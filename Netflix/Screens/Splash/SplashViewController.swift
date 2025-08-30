import UIKit
import Lottie

final class SplashViewController: UIViewController {
    
    private let movieAnimation = LottieAnimationView(name: "moviesplash")
    private let endingAnimation = LottieAnimationView(name: "endingeffect")
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "MovieScope"
        lbl.font = UIFont(name: "CinzelDecorative-Bold", size: 40) ?? .boldSystemFont(ofSize: 40)
        lbl.textColor = .white
        lbl.alpha = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Discover Movies in Seconds" 
        lbl.font = UIFont(name: "AvenirNext-MediumItalic", size: 18) ?? .italicSystemFont(ofSize: 18)
        lbl.textColor = UIColor(white: 0.9, alpha: 0.9)
        lbl.alpha = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        movieAnimation.contentMode = .scaleAspectFit
        movieAnimation.loopMode = .playOnce
        movieAnimation.alpha = 0
        
        endingAnimation.contentMode = .scaleAspectFill
        endingAnimation.loopMode = .playOnce
        endingAnimation.alpha = 0
        
        view.addSubview(movieAnimation)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(endingAnimation)
        view.sendSubviewToBack(endingAnimation)
        
        movieAnimation.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        endingAnimation.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            movieAnimation.widthAnchor.constraint(equalToConstant: 200),
            movieAnimation.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: movieAnimation.bottomAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            endingAnimation.topAnchor.constraint(equalTo: view.topAnchor),
            endingAnimation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            endingAnimation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            endingAnimation.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.8) {
            self.movieAnimation.alpha = 1
        } completion: { _ in
            self.movieAnimation.play { _ in
                // MovieScope → MoScope geçişi
                UIView.transition(with: self.titleLabel, duration: 1.0, options: .transitionCrossDissolve, animations: {
                    self.titleLabel.alpha = 1
                    self.titleLabel.text = "MoScope"
                    self.titleLabel.font = UIFont(name: "Montserrat-Bold", size: 42) ?? .boldSystemFont(ofSize: 42)
                }) { _ in
                    // Küçük bounce animasyonu
                    UIView.animate(withDuration: 0.6,
                                   delay: 0,
                                   usingSpringWithDamping: 0.6,
                                   initialSpringVelocity: 0.8,
                                   options: .curveEaseInOut,
                                   animations: {
                        self.titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    }) { _ in
                        UIView.animate(withDuration: 0.4) {
                            self.titleLabel.transform = .identity
                        }
                    }
                    
                    // Slogan fade-in
                    UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn, animations: {
                        self.subtitleLabel.alpha = 1
                    }) { _ in
                        // 1.5 sn bekle → ending animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.showEndingAndExit()
                        }
                    }
                }
            }
        }
    }
    
    private func showEndingAndExit() {
        UIView.animate(withDuration: 0.6) {
            self.endingAnimation.alpha = 1
        }
        
        endingAnimation.play { _ in
            self.transitionToRoot()
        }
    }
    
    private func transitionToRoot() {
        let mainVC = LoginViewController()

        let nav = UINavigationController(rootViewController: mainVC)
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        
        UIView.transition(with: window,
                          duration: 1.0,
                          options: [.transitionCrossDissolve],
                          animations: {
            window.rootViewController = nav
        })
    }
}
