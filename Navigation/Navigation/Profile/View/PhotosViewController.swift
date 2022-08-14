//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Vadim on 07.03.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    // MARK: - Task 8

    let processor = ImageProcessor()
    var newPhotosArray: [UIImage] = []
    var timer: Timer?
    var counter: Double = 0

    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .gray
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Gallery"
        self.view.addSubviews(photosCollectionView, indicator)
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        setupConstraints()

        // MARK: - Task 8
        processor.processImagesOnThread(sourceImages: arrayPhotos,
                                        filter: .fade,
                                        qos: .userInitiated) { filtres in
            self.newPhotosArray.removeAll()
            for value in filtres {
                guard let value = value else { return }
                self.newPhotosArray.append(UIImage(cgImage: value))
            }
            DispatchQueue.main.async {
                self.photosCollectionView.reloadData()
                self.indicator.stopAnimating()
            }

        }

        timer = Timer.scheduledTimer(timeInterval: 0.05,
                                     target: self,
                                     selector: #selector(startTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc func startTimer() {
        counter += 0.05
        if !newPhotosArray.isEmpty {
            print("Затрачено времени - \(counter)")
            timer?.invalidate()
        }
    }

    /*
     background - 14.293999999997517
     userInteractive - 3.668999999999707
     default - 3.714999999999702
     utility - 3.886999999999683
     userInitiated - 3.868999999999685
     */

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false

    }

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()

    lazy var photosCollectionView: UICollectionView = {
        let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photosCollectionView.backgroundColor = .white
        photosCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        
        return photosCollectionView
    }()

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItem: CGFloat = 3
        let accessibleWidth = collectionView.frame.width - 32
        let widthItem = (accessibleWidth / countItem)

        return CGSize(width: widthItem, height: widthItem)
    }
}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotosArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.configCellCollection(photo: newPhotosArray[indexPath.item])

        return cell
    }
}
