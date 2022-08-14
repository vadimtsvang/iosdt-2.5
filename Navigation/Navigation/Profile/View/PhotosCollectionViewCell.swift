//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Vadim on 07.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    var photos: UIImageView = {
        let photos = UIImageView()
        photos.translatesAutoresizingMaskIntoConstraints = false
        return photos
    }()

    public func configCellCollection(photo: UIImage) {
        self.photos.image = photo
    }

    private func setupConstraints() {
        self.contentView.addSubview(photos)
        NSLayoutConstraint.activate([
            photos.topAnchor.constraint(equalTo: contentView.topAnchor),
            photos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photos.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photos.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
