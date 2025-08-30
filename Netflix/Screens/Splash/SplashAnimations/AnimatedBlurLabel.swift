/*import UIKit

class AnimatedBlurLabel: UILabel {
    
    private var blurEffectView: UIVisualEffectView?
    
    func setBlur(_ isBlurred: Bool) {
        blurEffectView?.removeFromSuperview()
        if isBlurred {
            let blurEffect = UIBlurEffect(style: .light)
            let view = UIVisualEffectView(effect: blurEffect)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(view, at: 0) // yazının üstünde değil, arkasında
            blurEffectView = view
        }
    }
    
    func animateBlur(in duration: TimeInterval,
                     completion: (() -> Void)? = nil) {
        UIView.transition(with: self,
                          duration: duration,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.setBlur(true)
        }, completion: { _ in
            UIView.transition(with: self,
                              duration: duration,
                              options: [.transitionCrossDissolve],
                              animations: {
                self.setBlur(false)
            }, completion: { _ in
                completion?()
            })
        })
    }
}
*/
