//
//  VideoCollectionViewCells.swift
//  tiktok
//
//  Created by J.Sarath Krishnaswamy on 18/02/21.
//

import UIKit
import AVKit

class VideoCollectionViewCells: UICollectionViewCell {
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    var player:AVPlayer? = nil
    var playerItem:AVPlayerItem? = nil
    var playerLayer:AVPlayerLayer? = nil
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        self.playerItem = nil
        self.playerLayer?.removeFromSuperlayer()
        
       
    }
    //play.fill
}
