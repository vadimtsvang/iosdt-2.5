//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Vadim on 03.06.2022.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    var url: String?
    var name: String = "" {
        didSet {
            titleVideo.text = name
        }
    }

    lazy var titleVideo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupConstraits() {
        contentView.addSubviews(titleVideo)

        NSLayoutConstraint.activate([
            titleVideo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleVideo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleVideo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configVideo(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
