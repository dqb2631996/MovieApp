import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    private func request<T: Decodable>(from apiURL: String,
                                       completion: @escaping (T) -> Void) {
        guard let url = URL(string: apiURL) else {
            print("Error URL")
            return
        }
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Error Repsonse")
                    return
                }
                guard let safeData = data else {
                    print("Error Data")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: safeData)
                    completion(result)
                } catch {
                    print(error)
                }
                }.resume()
        }
    }
}

extension NetworkManager {
    func getMovieData(page: Int, sortType: SortType ,completion: @escaping (DiscoverMovieResponse) -> Void) {
        let url = URLs.baseURL + "/discover/movie?api_key=" + APIKey.apiKey + "&language=en-US&sort_by=\(sortType.apiParam)&include_adult=false&include_video=false&page=\(page)&with_watch_monetization_types=flatrate"
        request(from: url, completion: completion)
    }
    
    func getMovieDetailData(id: Int, completion: @escaping (MovieDetail) -> Void)  {
        let url = URLs.baseURL + "/movie/" + String(id) + "?api_key=" + APIKey.apiKey + "&language=en-US"
        request(from: url, completion: completion)
    }
    
    func getCastMovieDetailData(id: Int, completion: @escaping (MovieCredits) -> Void)  {
        let url = URLs.baseURL + "/movie/\(id)/credits?api_key=" + APIKey.apiKey + "&language=en-US"
        request(from: url, completion: completion)
    }
}
