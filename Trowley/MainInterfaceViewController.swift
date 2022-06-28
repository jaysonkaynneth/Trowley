//
//  MainInterfaceViewController.swift
//  Trowley
//
//  Created by audrey on 28/06/22.
//
import AVFoundation
import AVKit

class MainInterfaceViewController: UIViewController {

    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo()
    }
    private func playVideo() {
            guard let path = Bundle.main.path(forResource: "TrowleySplashVid", ofType:"mp4") else {
                debugPrint("video.m4v not found")
                return
            }
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            let playerController = AVPlayerViewController()
            playerController.player = player
            present(playerController, animated: true) {
                player.play()
            }
        }
//    private func loadVideo() {
//
//        //this line is important to prevent background music stop
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
//        } catch { }
//
//        let path = NSBundle.mainBundle().pathForResource("your path", ofType:"mp4")
//
//        player = AVPlayer(URL: NSURL(fileURLWithPath: path!))
//        let playerLayer = AVPlayerLayer(player: player)
//
//        playerLayer.frame = self.view.frame
//        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//        playerLayer.zPosition = -1
//
//        self.view.layer.addSublayer(playerLayer)
//
//        player?.seekToTime(kCMTimeZero)
//        player?.play()
//    }

}
