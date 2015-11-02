//
//  ViewController.swift
//  SampleRadioApp
//
//  Created by Lucian Cancescu on 15/11/14.
//  Copyright (c) 2014 Lucian Cancescu. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playButton.setTitle("Play", forState: UIControlState.Normal)
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
//            let image:UIImage = UIImage(named: "logo_player_background")!
//            let albumArt = MPMediaItemArtwork(image: image)
            let songInfo = [
                MPMediaItemPropertyTitle : "Radio Brasov",
                MPMediaItemPropertyArtist : "87,8fm"
//                MPMediaItemPropertyArtwork: albumArt
            ]
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("Receiving remote control events")
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        } catch {
            print("Audio Session error.")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        toggle()
    }

    func toggle() {
        if RadioPlayer.sharedInstance.currentlyPlaying() {
            pauseRadio()
        } else {
            playRadio()
        }
    }
    
    func playRadio() {
        RadioPlayer.sharedInstance.play()
        playButton.setTitle("Pause", forState: UIControlState.Normal)
    }
    
    func pauseRadio() {
        RadioPlayer.sharedInstance.pause()
        playButton.setTitle("Play", forState: UIControlState.Normal)
    }
}

