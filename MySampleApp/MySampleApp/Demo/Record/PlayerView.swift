import UIKit
import AVFoundation

class PlayerView: UIView {
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    
}
