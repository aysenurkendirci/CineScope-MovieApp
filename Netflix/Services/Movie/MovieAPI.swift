import Foundation
import Moya

enum MovieAPI {
    case popular
    case nowPlaying
    case upcoming
    
    case detail(movieId: Int)
    case credits(movieId: Int)
    case videos(movieId: Int)
    case search(query: String)
}

extension MovieAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .nowPlaying:
            return "/movie/now_playing"
        case .upcoming:
            return "/movie/upcoming"
        case .detail(let id):
            return "/movie/\(id)"
        case .credits(let id):
            return "/movie/\(id)/credits"
        case .videos(let id):
            return "/movie/\(id)/videos"
        case .search:
            return "/search/movie"
        }
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        let apiKey = "0b5ecf3c47cb1d15c596f71aa6d536f1"
        var params: [String: Any] = [
            "api_key": apiKey,
            "language": "tr-TR"
        ]
        
        switch self {
        case .search(let query):
            params["query"] = query
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        default:
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
