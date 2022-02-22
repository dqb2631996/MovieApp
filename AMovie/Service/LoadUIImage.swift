import Foundation
import UIKit
//
//extension UIImageView {
//    func getImageFromUrl(url: String) {
//        if let url = URL(string: URLs.imageBaseURL + url) {
//            DispatchQueue.main.async {
//                if let data = try? Data(contentsOf: url) {
//                    self.image = UIImage(data: data)
//                } else {
//                    self.image = UIImage()
//                    self.backgroundColor = .purple
//                }
//            }
//        }
//    }
//}

extension UIImageView {

    func getImageFromUrl(url: String, _ placeHolder: UIImage? = nil) {
        guard let url = URL(string: URLs.imageBaseURL + url) else {
            image = placeHolder
            return
        }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.backgroundColor = .gray
            }
        }
    }
    
    func loadImageFromUrl(imageUrl: String) -> URLSessionDataTask? {
        guard let url = URL(string: imageUrl)
            else { return nil }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error fetching the image! 😢")
                } else {
                    self.image = UIImage(data: data!)
                    self.backgroundColor = .gray
                }
            }
        }
        
        dataTask.resume()
        return dataTask
    }
}



