//
//  WebImage.swift
//  SDWebImageSwiftUIDemo
//
//  Created by lizhuoli on 2019/7/26.
//  Copyright © 2019 lizhuoli. All rights reserved.
//

import SwiftUI
import SDWebImage

public struct WebImage : View {
    public var url: URL
    public var placeholder: Image?
    public var options: SDWebImageOptions
    public var context: [SDWebImageContextOption : Any]?
    
    @ObjectBinding var imageManager: ImageManager
    
    public init(url: URL, placeholder: Image? = nil, options: SDWebImageOptions = [], context: [SDWebImageContextOption : Any]? = nil) {
        self.url = url
        self.placeholder = placeholder
        self.options = options
        self.context = context
        self.imageManager = ImageManager(url: url, options: options, context: context)
    }
    
    public var body: some View {
        if let image = imageManager.image {
            return Image(uiImage: image)
                .resizable()
                .onAppear {}
                .onDisappear {}
        } else if let image = placeholder {
                return image
                    .resizable()
                    .onAppear { self.imageManager.load() }
                    .onDisappear { self.imageManager.cancel() }
        } else {
            return Image(uiImage: UIImage())
                .resizable()
                .onAppear { self.imageManager.load() }
                .onDisappear { self.imageManager.cancel() }
        }
    }
}