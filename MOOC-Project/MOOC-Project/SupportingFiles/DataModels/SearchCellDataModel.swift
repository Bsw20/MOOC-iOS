//
//  SearchCellDataModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 02.05.2021.
//

import SwiftUI

struct SearchCellDataModel: Identifiable {
    var id: String
    var vendorName: String
    var vendorIcon: String
    var courseName: String
    var courseRating: Double
    var courseImage: String
    var price: CourseParsedPriceDataModel
    var shortDescription: String
    var countViews: Int
}

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                Logger.logNetWork(description: "Invalid image URL: \(url)", logType: .error)
                state = .failure
                return
            }

            URLSession.shared.dataTask(with: parsedURL) { data, _, _ in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: String,
         loading: Image = Image(systemName: "photo"),
         failure: Image = Image(uiImage: UIImage())) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
