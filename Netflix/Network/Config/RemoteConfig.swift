// RC.swift
import Foundation
import FirebaseRemoteConfig

final class RC {
    static let shared = RC()
    
    private let rc = RemoteConfig.remoteConfig()
    private var loaded = false
    
    private init() {
        let s = RemoteConfigSettings()
        s.minimumFetchInterval = 0
        rc.configSettings = s
        
        rc.setDefaults([
            "openai_api_key": "" as NSString,
            "rec_model": "gpt-4o-mini" as NSString,
            "rec_min_vote_avg": NSNumber(value: 6.3),
            "rec_short_runtime_max": NSNumber(value: 100),
            "tmdb_api_key": "" as NSString,
            "profile_avatar_urls": "[]" as NSString
        ])
    }
    
    func ensureLoaded() async throws {
        guard !loaded else { return }
        try await withCheckedThrowingContinuation { (cont: CheckedContinuation<Void, Error>) in
            rc.fetchAndActivate { _, error in
                if let e = error { cont.resume(throwing: e) }
                else { self.loaded = true; cont.resume(returning: ()) }
            }
        }
    }

    // ---- READS
    var openAIKey: String { rc["openai_api_key"].stringValue }
    var model: String { rc["rec_model"].stringValue }
    var minVote: Double { rc["rec_min_vote_avg"].numberValue.doubleValue }
    var recShortRuntimeMax: Int { rc["rec_short_runtime_max"].numberValue.intValue }
    var tmdbKey: String { rc["tmdb_api_key"].stringValue }
    
    var avatarURLs: [String] {
        let raw = rc["profile_avatar_urls"].stringValue
        return (try? JSONDecoder().decode([String].self, from: Data(raw.utf8))) ?? []
    }
    var avatarURLsOrFallback: [String] {
        let arr = avatarURLs
        return arr.isEmpty ? [
            "https://picsum.photos/seed/avatar1/240",
            "https://picsum.photos/seed/avatar2/240",
            "https://picsum.photos/seed/avatar3/240",
            "https://picsum.photos/seed/avatar4/240",
            "https://picsum.photos/seed/avatar5/240"
        ] : arr
    }
}
