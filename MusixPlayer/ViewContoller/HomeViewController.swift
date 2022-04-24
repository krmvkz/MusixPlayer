//
//  HomeViewController.swift
//  MusixPlayer
//
//  Created by balaTTV on 24.04.2022.
//

import UIKit
import AVFoundation

final class HomeViewController: UIViewController {

// - MARK: Outlets
    @IBOutlet private weak var albumsCollectionView: UICollectionView!
    @IBOutlet private weak var songsTableView: UITableView!
    
// - MARK: Properties
    var player: AVAudioPlayer!
    var songIndex: Int = 0
    var isNotPlaying: Bool = false
    
    private var albums: [Album] = [
        Album(albumCover: UIImage(named: "glassAnimals-album")!, albumTitle: "This is Glass Animals", albumArtist: ["Glass Animals"], songs: [
            Song(coverImage: UIImage(named: "heatwaves-cover")!, title: "Heat Waves", artist: ["Glass Animals"], musicID: "heatwaves"),
            Song(coverImage: UIImage(named: "sunroof-cover")!, title: "Sunroof", artist: ["Nicky Youre", "Dazy"], musicID: "sunroof")
        ]),
        Album(albumCover: UIImage(named: "glassAnimals-album")!, albumTitle: "This is Glass Animals", albumArtist: ["Glass Animals"], songs: [
            Song(coverImage: UIImage(named: "heatwaves-cover")!, title: "Heat Waves", artist: ["Glass Animals"], musicID: "heatwaves"),
            Song(coverImage: UIImage(named: "sunroof-cover")!, title: "Sunroof", artist: ["Nicky Youre", "Dazy"], musicID: "sunroof")
        ]),
        Album(albumCover: UIImage(named: "glassAnimals-album")!, albumTitle: "This is Glass Animals", albumArtist: ["Glass Animals"], songs: [
            Song(coverImage: UIImage(named: "heatwaves-cover")!, title: "Heat Waves", artist: ["Glass Animals"], musicID: "heatwaves"),
            Song(coverImage: UIImage(named: "sunroof-cover")!, title: "Sunroof", artist: ["Nicky Youre", "Dazy"], musicID: "sunroof")
        ]),
        Album(albumCover: UIImage(named: "glassAnimals-album")!, albumTitle: "This is Glass Animals", albumArtist: ["Glass Animals"], songs: [
            Song(coverImage: UIImage(named: "heatwaves-cover")!, title: "Heat Waves", artist: ["Glass Animals"], musicID: "heatwaves"),
            Song(coverImage: UIImage(named: "sunroof-cover")!, title: "Sunroof", artist: ["Nicky Youre", "Dazy"], musicID: "sunroof")
        ])
        
    ]
    
    private let songs: [Song] = [
        Song(coverImage: UIImage(named: "heatwaves-cover")!, title: "Heat Waves", artist: ["Glass Animals"], musicID: "heatwaves"),
        Song(coverImage: UIImage(named: "sunroof-cover")!, title: "Sunroof", artist: ["Nicky Youre", "Dazy"], musicID: "sunroof")
    ]
    
// - MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setProtocolConformance()
        registerCells()
        self.albumsCollectionView.reloadData()
        self.songsTableView.reloadData()
    }

}

// - MARK: Methods
extension HomeViewController {
    
    private func setProtocolConformance() {
        albumsCollectionView.dataSource = self
        albumsCollectionView.delegate = self
        songsTableView.dataSource = self
        songsTableView.delegate = self
        
    }
    
    private func registerCells() {
        let collectionNib = UINib.init(nibName: "AlbumCell", bundle: Bundle(for: AlbumCell.self))
        albumsCollectionView.register(collectionNib, forCellWithReuseIdentifier: "AlbumCell")
        let nib = UINib(nibName: "SongCell", bundle: Bundle(for: SongCell.self))
        songsTableView.register(nib, forCellReuseIdentifier: "SongCell")
    }
    
}

// - MARK: CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        let album = albums[indexPath.row]
        cell.configureCell(with: album)
        return cell
    }
    
}


// - MARK: CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main.self)
        let vc = storyboard.instantiateViewController(withIdentifier: "SongListViewController") as! SongListViewController
        if let albumSongs = albums[indexPath.row].songs
        {
            vc.songs = albumSongs
        }
        self.show(vc, sender: self)
        
    }
}

// - MARK: TableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        let song = songs[indexPath.row]
        cell.configureCell(with: song)
        return cell
    }
    
}

// - MARK: TableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main.self)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        vc.songIndex = indexPath.row
        vc.songs = self.songs
        self.present(vc, animated: true)
    }
    
}





