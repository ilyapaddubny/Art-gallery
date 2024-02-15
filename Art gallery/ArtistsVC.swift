//
//  ArtistsVC.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 14.02.2024.
//

import UIKit

class ArtistsVC: UIViewController {
    
    let tableView = UITableView()
    let dataManager = DataManager()
    
    var artists: [Artist] {
        get {
            UserDefaults(suiteName: Constants.Strings.group)?.artists(forKey: Constants.Strings.key) ?? []
        }
        set {
            if let sharedDefaults = UserDefaults(suiteName: Constants.Strings.group) {
                sharedDefaults.setValue(newValue, forKey:  Constants.Strings.key)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if artists.isEmpty {
            print("ℹ️ getting data online...")
            fetchDataOnline()
        }
        title = Constants.Strings.title
        configureUI()
    }
    
    private func configureUI() {
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: "artistCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.center = view.center
        tableView.frame = view.bounds
        
    }
    
    // MARK: - Data layer
    func fetchDataOnline() {
        dataManager.fetchDataOnline { [weak self] result in
            switch result {
            case .success(let artists):
                self?.artists = artists
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    // MARK: - Constants
    private struct Constants {
        struct Strings {
            static let key = "artists"
            static let title = "Artists"
            static let group = "group.paddubny.Art-gallery"
        }
    }
    
}



extension ArtistsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artistGalleryVC = ArtistGalleryVC(artist: artists[indexPath.row])
        artistGalleryVC.navigationItem.title = artists[indexPath.row].name
        
        navigationController?.pushViewController(artistGalleryVC, animated: false) //TODO: animated true works bad. Figure out WTF
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! ArtistTableViewCell
        
        let artist = artists[indexPath.row]
        cell.nameLabel.text = artist.name
        cell.bioLabel.text = artist.bio
        cell.artistImage.image = UIImage(named: artist.image)
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension UserDefaults {
    func artists(forKey key: String) -> [Artist] {
        if let jsonData = data(forKey: key),
           let decodedArtists = try? JSONDecoder().decode([Artist].self, from: jsonData) {
            return decodedArtists
        } else {
            return []
        }
    }
    
    func setValue(_ artists: [Artist], forKey key: String) {
        if artists.isEmpty {
            removeObject(forKey: key)
        } else {
            if let encodedData = try? JSONEncoder().encode(artists){
                set(encodedData, forKey: key)
            }
                
        }
    }
}
