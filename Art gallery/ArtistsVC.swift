//
//  ArtistsVC.swift
//  Art gallery
//
//  Created by Ilya Paddubny on 14.02.2024.
//

import UIKit

class ArtistsVC: UIViewController {
    
    var tableView = UITableView()
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        title = "Artists"
        configureUI()
    }
    
    private func configureUI() {
        tableView.center = view.center
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    //MARK: - Data layer
    func fetchDataOnline() {
        guard let url = URL(string: Constants.artistURLString) else {
            print("🔴 Invalid URL")
            return
        }
        
        let urlSession = URLSession.shared
        
        // Creating a data task to fetch the data from the URL
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🔴 \(error.localizedDescription)")
                return
            }
            
           guard let httpResponse = response as? HTTPURLResponse,
                 (200...209).contains(httpResponse.statusCode) else {
               print("🔴 Invalid response")
               return
           }
            
            guard let jsonData = data else {
                print("🔴 No data received")
                return
            }
            
            guard let artistsData = try? JSONDecoder().decode(ArtistsData.self, from: jsonData) else {
                print("🔴 Failed to decode artists data")
                return
            }
            
            let artists = artistsData.artists
            
            UserDefaults(suiteName: "group.paddubny.Art-gallery")?.setValue(artists, forKey: ArtistsVC.Constants.Strings.key)
        }
        
        task.resume()
        
        struct Constants {
            static let artistURLString = "https://file.notion.so/f/f/b8bbfa88-ab7c-464e-8c0e-1c109af93066/8c0c0258-c23a-4229-ae76-b515867cc1d8/artists.json?id=65f3a8fb-a15e-48f4-a7ed-f75be1b2f4fb&table=block&spaceId=b8bbfa88-ab7c-464e-8c0e-1c109af93066&expirationTimestamp=1708005600000&signature=BqHK8Pd5dUdAbQyCCHky4wrWjAxXXgzjq9moJlYFvFc&downloadName=artists.json"
        }
    }
    
    private struct Constants {
        struct Strings {
            static let key = "artists"
            static let group = "group.paddubny.Art-gallery"
        }
    }
    
}



extension ArtistsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artistGalleryVC = ArtistGalleryVC()
        artistGalleryVC.testLabel.text = artists[indexPath.row].name
        artistGalleryVC.navigationItem.title = artists[indexPath.row].name
        
        navigationController?.pushViewController(artistGalleryVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = artists[indexPath.row].name
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
