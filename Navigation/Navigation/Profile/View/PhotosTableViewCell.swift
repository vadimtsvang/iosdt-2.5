//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Vadim on 07.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    var labelPhotos: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrow
    }()

    var stackViewImage: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()

   lazy var previewImageOne: UIImageView = {
        let preview = UIImageView()
        preview.image = arrayPhotos[0]
        preview.layer.cornerRadius = 6
        preview.clipsToBounds = true
        return preview
    }()

    lazy var previewImageTwo: UIImageView = {
        let preview = UIImageView()
        preview.image = arrayPhotos[1]
        preview.layer.cornerRadius = 6
        preview.clipsToBounds = true
        return preview
    }()

    lazy var previewImageThree: UIImageView = {
        let preview = UIImageView()
        preview.image = arrayPhotos[2]
        preview.layer.cornerRadius = 6
        preview.clipsToBounds = true
        return preview
    }()

    lazy var previewImageFour: UIImageView = {
        let preview = UIImageView()
        preview.image = arrayPhotos[3]
        preview.layer.cornerRadius = 6
        preview.clipsToBounds = true
        return preview
    }()

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            labelPhotos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indentTwelve),
            labelPhotos.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indentTwelve),

            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.indentTwelve),
            arrowImage.centerYAnchor.constraint(equalTo: labelPhotos.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 40),
            arrowImage.widthAnchor.constraint(equalToConstant: 40),

            stackViewImage.topAnchor.constraint(equalTo: labelPhotos.bottomAnchor, constant: Constants.indentTwelve),
            stackViewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indentTwelve),
            stackViewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.indentTwelve),
            stackViewImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indentTwelve),

            previewImageOne.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 24) / 4),
            previewImageOne.heightAnchor.constraint(equalTo: previewImageOne.widthAnchor),

            previewImageTwo.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 24) / 4),
            previewImageTwo.heightAnchor.constraint(equalTo: previewImageTwo.widthAnchor),

            previewImageThree.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 24) / 4),
            previewImageThree.heightAnchor.constraint(equalTo: previewImageThree.widthAnchor),

            previewImageFour.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 24) / 4),
            previewImageFour.heightAnchor.constraint(equalTo: previewImageFour.widthAnchor),
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:   reuseIdentifier)
        contentView.addSubviews(labelPhotos, arrowImage, stackViewImage)
        stackViewImage.addArrangedSubview(previewImageOne)
        stackViewImage.addArrangedSubview(previewImageTwo)
        stackViewImage.addArrangedSubview(previewImageThree)
        stackViewImage.addArrangedSubview(previewImageFour)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
