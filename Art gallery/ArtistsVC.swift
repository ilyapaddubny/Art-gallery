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
    var filteredArtists: [Artist] = []
    
    
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
        filteredArtists = artists
        title = Constants.Strings.title
        configureUI()
    }
    
    private func configureUI() {
        configureTableView()
        configureSearchView()
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
    
    private func configureSearchView() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Data layer
    func fetchDataOnline() {
        dataManager.fetchDataOnline { [weak self] result in
            switch result {
            case .success(let artists):
                self?.artists = artists
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.filteredArtists = artists
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
        let artistGalleryVC = ArtistGalleryVC(artist: filteredArtists[indexPath.row])
        artistGalleryVC.navigationItem.title = filteredArtists[indexPath.row].name
        
        navigationController?.pushViewController(artistGalleryVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArtists.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! ArtistTableViewCell
        
        let artist = filteredArtists[indexPath.row]
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

extension ArtistsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(),
              searchText.count >= 2 else {
            filteredArtists = artists
            tableView.reloadData()
            return
        }

        // Filter specifically by artist name
        let filterResult = artists.filter { artist in
            return artist.name.lowercased().contains(searchText.lowercased())
        }
        filteredArtists = filterResult
        // UI configure
        // Reload the table view with the filtered results
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Handle cancel button tapped
        searchBar.text = ""
        print("ℹ️ Cancel button tapped")
        // Reset filtered results and search flag
        filteredArtists = artists
        //            isSearching = false
        tableView.reloadData()
    }
}
