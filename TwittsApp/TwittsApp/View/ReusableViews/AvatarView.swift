//
//  AvatarButton.swift
//  Gap
//
//  Created by eslami on 7/1/20.
//  Copyright © 2020 TSIT. All rights reserved.
//

import Foundation
import Kingfisher
import SnapKit
import UIKit

class AvatarView: UIImageView {
    let placeHolderImage = UIImage(named: "ImagePlaceHolder")

    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        self.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        layer.cornerRadius = bounds.height / 2
    }

    func setImage(urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            kf.setImage(with: url, placeholder: placeHolderImage)
        } else {
            image = placeHolderImage
        }
    }

    func cancelImageLoad() {
        self.kf.cancelDownloadTask()
        image = placeHolderImage
    }
}
