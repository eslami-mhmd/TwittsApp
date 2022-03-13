//
//  AvatarView.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/10/22.
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
