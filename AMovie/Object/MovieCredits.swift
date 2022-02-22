
import Foundation
class MovieCredits : Codable {
    var id: Int?
    var cast: [Cast] = []
    
    init(id: Int, cast: [Cast]) {
        self.id = id
        self.cast = cast
    }
}
