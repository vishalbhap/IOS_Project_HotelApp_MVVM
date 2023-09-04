//
//  AsyncImageCache.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 23/08/23.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var imageCache: [URL: UIImage] = [:]

    func loadImage(from url: URL) async {
        if imageCache[url] != nil {
            // Image already cached, no need to download again
            return
        }

        do {
            // Use URLSession to fetch image data from the provided URL.
            let (data, _) = try await APIConfig.urlSession.data(from: url)
            if let image = UIImage(data: data) {
                // Once the image data is received, update the cache on the main thread.
                DispatchQueue.main.async {
                    self.imageCache[url] = image
                }
            }
        } catch {
            print("Image download error: \(error)")
        }
    }
}

struct AsyncImageView: View {
    @StateObject var imageLoader = ImageLoader()
    let url: URL

    var body: some View {
        if let image = imageLoader.imageCache[url] {
            // If the image is cached, display it immediately.
            SwiftUI.Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .cornerRadius(25)
        } else {
            // If the image is not cached, show a placeholder and initiate image loading.
            SwiftUI.Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .cornerRadius(25)
                .task {
                    // Initiate the asynchronous image loading process.
                    await imageLoader.loadImage(from: url)
                }
        }
    }
}



