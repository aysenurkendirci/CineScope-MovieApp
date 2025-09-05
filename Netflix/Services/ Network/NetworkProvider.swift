import Moya

struct NetworkProvider {
    static let shared = MoyaProvider<MovieAPI>(
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
    )
}
//.verbase ayrıntı için
