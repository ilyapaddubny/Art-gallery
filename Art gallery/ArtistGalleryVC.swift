//
//  ArtistGalleryVC.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 14.02.2024.
//

import UIKit

class ArtistGalleryVC: UIViewController {
    let artist: Artist
    
    let artistImage = UIImageView()
    let bioLabel = UILabel()
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)

        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func configureUI() {
        configureArtistImage()
        configureBioLabel()
        configureCollectionView()
    }
    
    private func configureArtistImage() {
        view.addSubview(artistImage)
        artistImage.image = UIImage(named: artist.image)
        
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        
        artistImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        artistImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26).isActive = true
        artistImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        artistImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        artistImage.contentMode = .scaleAspectFit
    }
    
    private func configureBioLabel() {
        view.addSubview(bioLabel)
        
        bioLabel.text = artist.bio
        bioLabel.textAlignment = .center
        
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bioLabel.topAnchor.constraint(equalTo: artistImage.bottomAnchor, constant: 16).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    
        bioLabel.numberOfLines = 0
    }
    
    private func configureCollectionView() {
        
        
        view.addSubview(collectionView)
        
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16).isActive = true
    }
    
    init(artist: Artist) {
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ArtistGalleryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pieceOfArtVC = PieceOfArtVC(pieceOfArt: artist.works[indexPath.row])
        pieceOfArtVC.title = artist.works[indexPath.row].title
        
        navigationController?.pushViewController(pieceOfArtVC, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artist.works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        
        let imageName = artist.works[indexPath.row].image
        cell.configure(with: UIImage(named: imageName))
        return cell
    }
    
    
}
