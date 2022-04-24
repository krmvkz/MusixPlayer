//
//  SongCell.swift
//  MusixPlayer
//
//  Created by balaTTV on 24.04.2022.
//

import UIKit

final class SongCell: UITableViewCell {
    
// - MARK: Outlets
    @IBOutlet private weak var songCoverImageView: UIImageView!
    @IBOutlet private weak var songTitleLabel: UILabel!
    @IBOutlet private weak var songArtistLabel: UILabel!
    @IBOutlet private weak var playerButton: UIButton!

// - MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// - MARK: Methods
extension SongCell {
    
    func configureCell(with song: Song) {
        songCoverImageView.image = song.coverImage
        songTitleLabel.text = song.title
        songArtistLabel.text = song.artist.joined(separator: ", ")
    }
    
    
    
}
