//
//  PieceOfArtVC.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 15.02.2024.
//

import UIKit

class PieceOfArtVC: UIViewController {
    
    let pieceOfArt: PieceOfArt
    
    let pieceOfArtImage = UIImageView()
    let pieceOfArtDescription = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func configureUI() {
        configurePieceOfArtImage()
        configurePieceOfArtLabel()
    }
    
    private func configurePieceOfArtImage() {
        view.addSubview(pieceOfArtImage)
        pieceOfArtImage.image = UIImage(named: pieceOfArt.image)
        
        pieceOfArtImage.translatesAutoresizingMaskIntoConstraints = false
        
        pieceOfArtImage.heightAnchor.constraint(equalToConstant: 350).isActive = true
        pieceOfArtImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26).isActive = true
        pieceOfArtImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        pieceOfArtImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        pieceOfArtImage.contentMode = .scaleAspectFit
    }
    
    private func configurePieceOfArtLabel() {
        view.addSubview(pieceOfArtDescription)
        
        pieceOfArtDescription.text = pieceOfArt.info
        pieceOfArtDescription.textAlignment = .center
        
        pieceOfArtDescription.translatesAutoresizingMaskIntoConstraints = false
        
        pieceOfArtDescription.topAnchor.constraint(equalTo: pieceOfArtImage.bottomAnchor, constant: 16).isActive = true
        pieceOfArtDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        pieceOfArtDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    
        pieceOfArtDescription.numberOfLines = 0
    }
    
    init(pieceOfArt: PieceOfArt) {
        self.pieceOfArt = pieceOfArt
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
