import SwiftUI
import UIKit

public final class ImageCache: @unchecked Sendable {
    public static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 200
        cache.totalCostLimit = 50 * 1024 * 1024
    }

    public func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    public func insert(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

@MainActor
final class CachedImageLoader: ObservableObject {
    @Published private(set) var image: UIImage?
    @Published private(set) var failed = false

    private let urlString: String
    private var task: Task<Void, Never>?

    init(urlString: String) {
        self.urlString = urlString
    }

    func load() {
        if let cached = ImageCache.shared.image(forKey: urlString) {
            image = cached
            return
        }
        guard let url = URL(string: urlString) else {
            failed = true
            return
        }
        task?.cancel()
        task = Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let downloaded = UIImage(data: data) else {
                    failed = true
                    return
                }
                ImageCache.shared.insert(downloaded, forKey: urlString)
                guard !Task.isCancelled else { return }
                image = downloaded
            } catch {
                if !Task.isCancelled {
                    failed = true
                }
            }
        }
    }

    func cancel() {
        task?.cancel()
        task = nil
    }
}

public struct CachedAsyncImage<Content: View, Placeholder: View, ErrorView: View>: View {
    @StateObject private var loader: CachedImageLoader
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder
    private let errorView: () -> ErrorView

    public init(
        urlString: String,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder error: @escaping () -> ErrorView
    ) {
        _loader = StateObject(wrappedValue: CachedImageLoader(urlString: urlString))
        self.content = content
        self.placeholder = placeholder
        self.errorView = error
    }

    public var body: some View {
        Group {
            if let uiImage = loader.image {
                content(Image(uiImage: uiImage))
            } else if loader.failed {
                errorView()
            } else {
                placeholder()
            }
        }
        .task {
            loader.load()
        }
        .onDisappear {
            loader.cancel()
        }
    }
}
