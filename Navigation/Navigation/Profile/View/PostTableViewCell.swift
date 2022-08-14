//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Vadim on 04.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var viewModel: PostTableViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                return
            }
            postTitle.text = viewModel.title
            postDescription.text = viewModel.description
            postImage.image = UIImage(named: viewModel.image)
            postLikes.text = "Likes: \(viewModel.likes)"
            postViews.text = "Views: \(viewModel.views)"
            postAuthor.text = "Author: \(viewModel.author)"
        }
    }
    
    var likePostsViewModel: LikePostsCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                return
            }
            postTitle.text = viewModel.title
            postDescription.text = viewModel.description
            postImage.image = UIImage(named: viewModel.image)
            postLikes.text = "Likes: \(viewModel.likes)"
            postViews.text = "Views: \(viewModel.views)"
            postAuthor.text = "Author: \(viewModel.author)"
        }
    }

    var counter: UInt?
    
    private lazy var postTitle: UILabel = {
        let postTitle = UILabel()
        postTitle.font =  .systemFont(ofSize: 20, weight: .bold)
        postTitle.textColor = .black
        postTitle.numberOfLines = 2
        return postTitle
    }()

    private lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.backgroundColor = .black
        postImage.contentMode = .scaleAspectFit
        return postImage
    }()

    private lazy var postDescription: UILabel = {
        let postDescription = UILabel()
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        return postDescription
    }()

    private lazy var postLikes: UILabel = {
        let postLikes = UILabel()
        postLikes.font = .systemFont(ofSize: 16)
        postLikes.textColor = .black
        return postLikes
    }()

    private lazy var postAuthor: UILabel = {
        let postDescription = UILabel()
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = .black
        postDescription.numberOfLines = 0
        return postDescription
    }()

    private lazy var postViews: UILabel = {
        let postViews = UILabel()
        postViews.font = .systemFont(ofSize: 16)
        postViews.textColor = .black
        return postViews
    }()

    private lazy var likesButtom: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.blue, renderingMode: .alwaysTemplate), for: .selected)
        button.addTarget(self, action: #selector(likeAction), for: .touchUpInside)

        return button
    }()

    @objc func likeAction() {
        guard let viewModel = viewModel else {
            return
        }
        if likesButtom.isSelected {
            likesButtom.isSelected = false
            postLikes.text = "Likes: \(viewModel.likes)"
        } else {
            likesButtom.isSelected = true

            postLikes.text = "Likes: \(viewModel.likes + 1)"
            }
        }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),

            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: Constants.indent),
            
            postAuthor.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: Constants.indent),
            postAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),

            postDescription.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: Constants.indent),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),


            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: Constants.indent),
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent),

            postLikes.topAnchor.constraint(equalTo: likesButtom.topAnchor),
            postLikes.leadingAnchor.constraint(equalTo: likesButtom.trailingAnchor, constant: 8),
            postLikes.heightAnchor.constraint(equalTo: likesButtom.heightAnchor),

            likesButtom.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: Constants.indent),
            likesButtom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            likesButtom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postTitle, postImage, postDescription, postLikes, postViews, likesButtom, postAuthor)
        self.selectionStyle = .none
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
