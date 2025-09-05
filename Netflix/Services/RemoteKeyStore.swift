/*
import FirebaseRemoteConfig

final class RemoteKeyStore {
    static let shared = RemoteKeyStore()
    private let rc = RemoteConfig.remoteConfig()
    private init() {
        let s = RemoteConfigSettings(); s.minimumFetchInterval = 0
        rc.configSettings = s
    }
    func fetchOpenAIKey(_ completion: @escaping (String?) -> Void) {
        rc.fetchAndActivate { _, _ in completion(self.rc["openai_api_key"].stringValue) }
    }
 }*/
