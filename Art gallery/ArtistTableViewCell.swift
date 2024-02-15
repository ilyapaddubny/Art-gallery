//
//  ArtistTableViewCell.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 15.02.2024.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    var nameLabel = UILabel()
    var bioLabel = UILabel()
    var artistImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        configureArtistImage()
        configureNameLabel()
        configureBioLabel()
    }
    
    private func configureArtistImage() {
        contentView.addSubview(artistImage)
        
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        
        artistImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        artistImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
        
        artistImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
        artistImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        artistImage.contentMode = .scaleAspectFit
    }
    
    private func configureNameLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    private func configureBioLabel() {
        contentView.addSubview(bioLabel)
        
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: artistImage.leadingAnchor, constant: -16).isActive = true
        bioLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    
        bioLabel.numberOfLines = 0
        bioLabel.textColor = .gray
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
