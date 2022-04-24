//
//  PlayerViewController.swift
//  MusixPlayer
//
//  Created by balaTTV on 24.04.2022.
//

import UIKit
//import AVFoundation
import AVFAudio

final class PlayerViewController: UIViewController {
    
// - MARK: Outlets
    @IBOutlet private weak var songCoverImageView: UIImageView!
    @IBOutlet private weak var songTitleLabel: UILabel!
    @IBOutlet private weak var songArtistLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var nowTimeLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var playerButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var previousButton: UIButton!
    
// - MARK: Properties
    var player: AVAudioPlayer!
    var songs: [Song] = []
    var songIndex: Int?
    
    var time: TimeInterval = 0.01
    var timer = Timer()
    var holdTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSong(index: songIndex!)
        updateView(with: songs[songIndex!])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopPlayer()
    }
    
    
// - MARK: Actions
    @IBAction func playButtonPressed(_ sender: UIButton) {
        if player.isPlaying {
            sender.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            pausePlayer()
        } else {
            sender.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            time = player.deviceCurrentTime
            playSong(at: time)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        playNext()
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        playPrevious()
    }
    
    @IBAction func fastForwardPressed(_ sender: UIButton) {
        time = player.currentTime
        time += 5.0
        if (time > player.duration) {
            playNext()
        } else {
            player.currentTime = time
            updateProgress()
        }
    }
    
    @IBAction func fastBackwardPressed(_ sender: UIButton) {
        time = player.currentTime
        time -= 5.0
        if (time < 0.0) {
            player.currentTime = 0.0
        } else {
            player.currentTime = time
            updateProgress()
        }
    }
    
}

// - MARK: Methods
extension PlayerViewController {
    
    private func playSong(index: Int) {
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        
        guard let song = songs[index].musicID else {
            return print("no such song")
        }
        if let path = Bundle.main.path(forResource: song, ofType: "mp3") {
            if let url = URL(string: path) {
                self.player = try? AVAudioPlayer(contentsOf: url)
                player.delegate = self
                durationLabel.text = player.duration.stringFromTimeInterval()
                updateProgress()
                player.prepareToPlay()
            }
        }
        playerButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
//        if player.isPlaying == false {
            self.player?.play()
//        }
        
    }
    
    private func playSong(at time: TimeInterval) {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        self.player.play(atTime: time)
    }
    
    private func pausePlayer() {
        timer.invalidate()
        self.player?.pause()
    }
    
    private func stopPlayer() {
        timer.invalidate()
        self.player.stop()
    }
    
    private func playNext() {
        songIndex! += 1
        if let index = songIndex {
            if index < songs.count {
                updateView(with: songs[index])
                playSong(index: index)
            } else {
                songIndex = 0
                updateView(with: songs[songIndex!])
                playSong(index: songIndex!)
            }
        }
    }
    
    private func playPrevious() {
        songIndex! -= 1
        if let index = songIndex {
            if index < 0 {
                songIndex = songs.count - 1
                updateView(with: songs[songIndex!])
                playSong(index: songIndex!)
            } else {
                updateView(with: songs[index])
                playSong(index: index)
            }
        }
    }
    
    private func updateView(with song: Song) {
        songCoverImageView.image = song.coverImage
        songTitleLabel.text = song.title
        songArtistLabel.text = song.artist.joined(separator: ", ")
    }
    
    @objc private func updateProgress() {
        if progressView.progress == 1.0 {
            playNext()
        } else {
            nowTimeLabel.text = player.currentTime.stringFromTimeInterval()
            progressView.progress = Float(player.currentTime / player.duration)
        }
    }
    
}

extension PlayerViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag == true {
            playNext()
        }
    }
    
}
