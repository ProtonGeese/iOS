import UIKit
import AVFoundation
import MediaPlayer
import MediaPlayer
import AVKit
import AWSS3
//import GoogleAPIClient
//import GTMOAuth2

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerView: PlayerView!
    let player = AVPlayer()
    var asset: AVURLAsset? {
        didSet {
            guard let newAsset = asset else { return }
            asynchronouslyLoadURLAsset(newAsset)
        }
    }
    var playerItem: AVPlayerItem? = nil {
        didSet {
            player.replaceCurrentItemWithPlayerItem(self.playerItem)
        }
    }
    private var playerLayer: AVPlayerLayer? {
        return playerView.playerLayer
    }
    let keyChainName = "CameraRecord"
    //let clientID = "449392154913-obh7qiq70kdqhuobkh6oh0l7kjh77sik.apps.googleusercontent.com"
    let clientID = ""
    //  lazy var services:GTLServiceDrive = {
    //    if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(self.keyChainName, clientID: //self.clientID, clientSecret: nil) {
    //$0.authorizer = auth
    //}
    //return $0
    //}(GTLServiceDrive())
    
    
    var urlFile:NSURL?
    var username:String = "student1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        asset = AVURLAsset(URL: urlFile!, options: nil)
        playerView.playerLayer.player = player // should be this other
    }
    
    @IBAction func touchUpCloseButton(_ sender: UIButton) {
        player.pause()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func touchUpPlayButton(_ playerButton: UIButton) {
        playerButton.enabled = false
        player.play()
    }
    
    @IBAction func touchUpUpLoadButton(_ uploadButton: UIButton) {
        uploadButton.enabled = false
        uploadRecord()
    }
}

extension PlayerViewController{
    func asynchronouslyLoadURLAsset(_ newAsset: AVURLAsset) {
        newAsset.loadValuesAsynchronouslyForKeys([]) {
            dispatch_async(dispatch_get_main_queue(), {
                guard newAsset == self.asset else {
                    return
                }
                self.playerItem = AVPlayerItem(asset: newAsset)
                }
            )
        }
    }
    
    func uploadRecord(){
        //_ = GTLUploadParameters(fileURL: urlFile!, MIMEType: "mov")
        //self.dismissViewControllerAnimated(true, completion: nil)
        
        //===================Upload Start======================
        print("Upload video method called.")
        // setup variables for s3 upload request
        let s3bucket = "osuhondaaep"
        let fileType = "mov"
        
        //prepare upload request
        print("preparing upload request...")
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest.bucket = s3bucket
        uploadRequest.key = "\(username)/\(username)L1U1C\(Int(NSDate().timeIntervalSince1970)).mov"
        uploadRequest.body = urlFile!
        uploadRequest.uploadProgress = { (bytesSent:Int64, totalBytesSent:Int64,  totalBytesExpectedToSend:Int64) -> Void in
            dispatch_sync(dispatch_get_main_queue(), {() -> Void in
                print("SENT: \(bytesSent)\tTOTAL: \(totalBytesSent)\t/\(totalBytesExpectedToSend)")
            })
        }
        uploadRequest.contentType = "video/" + fileType
        print("upload request preparation complete.")
        AWSS3TransferManager.defaultS3TransferManager().upload(uploadRequest).continueWithBlock{ (task) -> AnyObject! in
            if let error = task.error{
                print("Upload failed (\(error)")
            }
            if let exception = task.exception{
                print("Upload failed (\(exception)")
            }
            if task.result != nil {
                let s3URL = NSURL(string: "http://s3.amazonaws.com/\(s3bucket)/\(uploadRequest.key!)")!
                print("Uploaded to: \n\(s3URL)")
            } else {
                print("***AWS S3 UPLOAD FAILED.")
            }
            
            return nil
        }
        //====================Upload End========================
        
        
        countVideo.count += 1
        if(countVideo.count == 1)
        {
            video2()
        }
        else if(countVideo.count == 2) {
            video3()
        }
        else if(countVideo.count == 3) {
            video4()
        }
        else if(countVideo.count == 4) {
            video5()
        }
        else
        {
            let storyboard = UIStoryboard(name: "VideoView", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("VideoView") as UIViewController
            presentViewController(vc, animated: true, completion: nil)
        }
        
    }
    
    func video2(){
        let videoURL = NSURL(string: "https://s3.amazonaws.com/aepios-userfiles-mobilehub-1099679197/public/Lesson1Part2.mp4")
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
    
    func video3(){
        let videoURL = NSURL(string: "https://s3.amazonaws.com/aepios-userfiles-mobilehub-1099679197/public/Lesson1Part3.mp4")
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
    
    func video4(){
        let videoURL = NSURL(string: "https://s3.amazonaws.com/aepios-userfiles-mobilehub-1099679197/public/Lesson1Part4.mp4")
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
    
    
    func video5(){
        let videoURL = NSURL(string: "https://s3.amazonaws.com/aepios-userfiles-mobilehub-1099679197/public/Lesson1Part5.mp4")
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
    
    
    func playerDidFinishPlaying(note:NSNotification){
        dismissViewControllerAnimated(true, completion: nil)
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("Record") as UIViewController
        presentViewController(vc, animated: true, completion: nil)
    }
}











