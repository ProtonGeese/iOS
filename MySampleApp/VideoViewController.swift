import UIKit
import MediaPlayer
import AVKit
import AVFoundation


class VideoViewController: UIViewController,AVAudioPlayerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sampleVideo(sender: UIButton) {
        playSampleVideo("https://s3.amazonaws.com/aepios-userfiles-mobilehub-1099679197/public/SampleVideo.mp4")
    }
    @IBAction func playVideo1(sender: UIButton) {
        video("https://s3.amazonaws.com/aepios-userfiles-mobilehub-1099679197/public/Lesson1Part1.mp4");
    }
    @IBAction func playVideo2(sender: UIButton) {
    }
    @IBAction func playVideo3(sender: UIButton) {
    }
    @IBAction func playVideo4(sender: UIButton) {
    }
    
    func video(url:String){
        let videoURL = NSURL(string: url)
        let player = AVPlayer(URL: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerDidFinishPlaying:",
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: playerViewController.player!.currentItem)
        
    }
 
    func playSampleVideo(url:String){
        let videoURL = NSURL(string: url)
        let player = AVPlayer(URL: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sampleVideoPlayerDidFinishPlaying:",
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: playerViewController.player!.currentItem)
        
    }
    
    func sampleVideoPlayerDidFinishPlaying(note:NSNotification){
        print("finished")
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func playerDidFinishPlaying(note:NSNotification){
        print("finished")
        dismissViewControllerAnimated(true, completion: nil)
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("Record") as UIViewController
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func record(){
        print("Recording")
    }

 
    
}

