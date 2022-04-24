//
//  SongListViewController.swift
//  MusixPlayer
//
//  Created by balaTTV on 24.04.2022.
//

import UIKit

final class SongListViewController: UIViewController {
    
// - MARK: Outlets
    @IBOutlet private weak var songListTableView: UITableView!
    
    var songs: [Song]?
    
// - MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setProtocolConformance()
        registerCells()
        self.songListTableView.reloadData()
    }

}

// - MARK: Methods
extension SongListViewController {
    
    private func setProtocolConformance() {
        songListTableView.dataSource = self
        songListTableView.delegate = self
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "SongCell", bundle: Bundle(for: SongCell.self))
        songListTableView.register(nib, forCellReuseIdentifier: "SongCell")
    }
    
}

// - MARK: TableViewDataSource
extension SongListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let songs = songs {
            return songs.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        if let songs = songs {
            cell.configureCell(with: songs[indexPath.row])
        }
        return cell
    }
    
}

// - MARK: TableViewDelegate
extension SongListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main.self)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        if let songs = songs {
            vc.songIndex = indexPath.row
            vc.songs = songs
        }
        
        self.present(vc, animated: true)
        
    }
    
}
