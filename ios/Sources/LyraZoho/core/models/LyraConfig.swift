public final class LyraConfig {
    var apiKey: String
    var baseUrl: String = "https://api.zoho.com"
    var timeoutMs: UInt64 = 15_000

    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}
