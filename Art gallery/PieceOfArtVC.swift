//
//  PieceOfArtVC.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 15.02.2024.
//

import UIKit

class PieceOfArtVC: UIViewController {
    
    let pieceOfArt: PieceOfArt
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let pieceOfArtImage = UIImageView()
    let pieceOfArtDescription = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func configureUI() {
        configureScrollView()
        configureContentView()
        configurePieceOfArtImage()
        configurePieceOfArtLabel()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureContentView() {
        contentView.addSubview(pieceOfArtImage)
        contentView.addSubview(pieceOfArtDescription)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    
    }
    
    
    private func configurePieceOfArtImage() {
        pieceOfArtImage.image = UIImage(named: pieceOfArt.image)
        
        pieceOfArtImage.translatesAutoresizingMaskIntoConstraints = false
        
        pieceOfArtImage.heightAnchor.constraint(equalToConstant: 350).isActive = true
        pieceOfArtImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26).isActive = true
        pieceOfArtImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        pieceOfArtImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        pieceOfArtImage.contentMode = .scaleAspectFit
    }
    
    private func configurePieceOfArtLabel() {
        
        pieceOfArtDescription.text = pieceOfArt.info
        pieceOfArtDescription.textAlignment = .center
        
        pieceOfArtDescription.translatesAutoresizingMaskIntoConstraints = false
        
        pieceOfArtDescription.topAnchor.constraint(equalTo: pieceOfArtImage.bottomAnchor, constant: 16).isActive = true
        pieceOfArtDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        pieceOfArtDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        pieceOfArtDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true

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
