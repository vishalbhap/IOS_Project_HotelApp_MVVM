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
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async { // Update the cache on the main thread
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
            SwiftUI.Image(uiImage: image)
                .resizable()
                .frame(width: 350, height: 220)
                .cornerRadius(25)
        } else {
            SwiftUI.Image(systemName: "photo")
                .resizable()
                .frame(width: 350, height: 220)
                .cornerRadius(25)
                .task {
                    await imageLoader.loadImage(from: url)
                }
        }
    }
}

