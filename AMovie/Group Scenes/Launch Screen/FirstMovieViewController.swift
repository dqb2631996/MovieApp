import UIKit

class FirstMovieViewController: UIViewController {
    
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
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func didTapNavigateToSecondScreenButton(_ sender: UIButton) {
        let secondVC = SecondMovieViewController()
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
