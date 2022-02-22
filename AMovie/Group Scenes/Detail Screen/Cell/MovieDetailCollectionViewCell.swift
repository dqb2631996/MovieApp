import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarActorImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()

    }
    func updateUI() {
        avatarActorImage.layer.cornerRadius = 10.0
        avatarActorImage.clipsToBounds = true
    }
}
