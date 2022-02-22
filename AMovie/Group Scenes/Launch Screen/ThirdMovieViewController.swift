import UIKit

class ThirdMovieViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
    }
    
    func updateLayout() {
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.cornerRadius = 27
        nextButton.clipsToBounds = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func didTapNavigateToListMovieScreenButton(_ sender: UIButton) {
        let movieVC = ListMovieViewController()
        self.navigationController?.pushViewController(movieVC, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}
