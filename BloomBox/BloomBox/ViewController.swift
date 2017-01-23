//
//  ViewController.swift
//  BloomBox
//
//  Created by Zachary Cheshire on 11/28/16.
//  Copyright © 2016 zcheshire. All rights reserved.
//

import UIKit
import AVFoundation
var songList = ["RunAway", "Father Stretch My Hands Pt1", "Can't Tell Me Nothing", "piano", "Break It Down Mix", "Loyalty Mix"]
class ViewController: UIViewController {
    
   
    var count = 0
    var time = Timer()
    var timer = Timer()
    var endTime = ""
    var startTime = ""
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scrubber: UISlider!
   // @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var labelStart: UILabel!
    @IBOutlet weak var labelEnd: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    var player = AVAudioPlayer()
    var random = Int(arc4random_uniform(UInt32(songList.count)))
    
   func updateScrubber() {
        scrubber.maximumValue = Float(player.duration)
        scrubber.value = Float(player.currentTime)
    endTime = String.init(format: "%.2f", (player.duration - player.currentTime) / 60)
    startTime = String.init(format: "%.2f", (player.currentTime / 60))
    labelEnd.text = endTime
    labelStart.text = startTime
    }
    
 
    @IBAction func sliderMoved(_ sender: Any) {
        player.volume = slider.value
    }
    
  
    @IBAction func play(_ sender: Any) {
        player.play()
        songLabel.text = "Now Playing: \(songList[random])"
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
 
        
        timer = Timer.scheduledTimer(timeInterval: player.duration - player.currentTime, target: self, selector: #selector(switchSong), userInfo: nil, repeats: false)
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
        timer.invalidate()
    }
    @IBAction func next(_ sender: Any) {
        timer.invalidate()
        time.invalidate()
        switchSong()
    }
    
    func switchSong() {
        scrubber.value = 0
        timer.invalidate()
        time.invalidate()
        count += 1
        print(count)
        random = Int(arc4random_uniform(UInt32(songList.count)))
        let audioPath = Bundle.main.path(forResource: songList[random], ofType: "mp3")
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        }
            
        catch {
            
        }
        
        player.play()
        songLabel.text = "Now Playing: \(songList[random])"
        
        timer = Timer.scheduledTimer(timeInterval: player.duration - player.currentTime, target: self, selector: #selector(switchSong), userInfo: nil, repeats: false)
        print("song \(player.duration)")
      //  var time = Timer()
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //scrubber.value = 0
    
        let audioPath = Bundle.main.path(forResource: songList[random], ofType: "mp3")
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        }
            
        catch {
            
        }
        
      /*  var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: player.duration, target: self, selector: #selector(switchSong), userInfo: nil, repeats: false)
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

