
import Foundation

class Cast: Codable {
    var id: Int?
    var character: String?
    var backgroundImage: String?

    init(id: Int, character: String, backgroundImage: String) {
        self.id = id
        self.character = character
        self.backgroundImage = backgroundImage
    }
    private enum CodingKeys : String, CodingKey {
        case id, character
        case backgroundImage = "profile_path"
        
    }
}
