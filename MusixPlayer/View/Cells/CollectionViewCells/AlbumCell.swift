//
//  AlbumCell.swift
//  MusixPlayer
//
//  Created by balaTTV on 24.04.2022.
//

import UIKit

final class AlbumCell: UICollectionViewCell {

// - MARK: Outlets
    @IBOutlet private weak var albumCoverImageView: UIImageView!
    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var albumArtistLalel: UILabel!
    
// - MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

// - MARK: Methods
extension AlbumCell {
    
    func configureCell(with album: Album) {
        albumCoverImageView.image = album.albumCover
        albumTitleLabel.text = album.albumTitle
        albumArtistLalel.text = album.albumArtist.joined(separator: ", ") + " and more"
    }
    
}
