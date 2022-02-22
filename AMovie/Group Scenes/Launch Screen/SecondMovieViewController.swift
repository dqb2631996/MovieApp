import UIKit

class SecondMovieViewController: UIViewController {
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
    
    @IBAction func didTapNavigateToThirdScreenButton(_ sender: Any) {
        let thirdVC = ThirdMovieViewController()
        navigationController?.pushViewController(thirdVC, animated: true)
    }
}
