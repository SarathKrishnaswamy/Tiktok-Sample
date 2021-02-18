//
//  ViewController.swift
//  tiktok
//
//  Created by J.Sarath Krishnaswamy on 18/02/21.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var ForYouBtn: UIButton!
    
    var urls = ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4","http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"]
    
    var index:Int! = 0
    var toggleState = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.ForYouBtn.layer.cornerRadius = 5.0
        
        let layout = UICollectionViewFlowLayout()
        CollectionView.showsVerticalScrollIndicator = false
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        self.CollectionView.contentInset = UIEdgeInsets(top:-44, left: 0, bottom:-34, right: 0)
        
        self.CollectionView.collectionViewLayout = layout
        
        
    }


}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCells", for: indexPath) as! VideoCollectionViewCells
        let screenSize: CGRect = UIScreen.main.bounds
        let datas = urls[indexPath.row]
        let url = URL.init(string: datas)
        cell.playerItem = AVPlayerItem(url: url!)
        //cell.player!.replaceCurrentItem(with: cell.playerItem)
       // cell.image.isHidden = true
        cell.player = AVPlayer(playerItem: cell.playerItem!)
        cell.playerLayer = AVPlayerLayer(player: cell.player!)
        cell.playerLayer!.frame = CGRect(x:0,y:0,width:screenSize.width,height: screenSize.height)
        cell.playerLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cell.playerView.layer.addSublayer(cell.playerLayer!)
        cell.playBtn.tag = indexPath.item
        cell.playBtn.addTarget(self, action: #selector(self.connected(_:)), for:.touchUpInside)
        cell.playBtn.isUserInteractionEnabled = true
        cell.playBtn.isEnabled = true
        cell.playerView.layer.backgroundColor = UIColor.black.cgColor
        
        cell.playBtn.setImage(UIImage(systemName:"pause.fill"), for: .normal)
        
        return cell
    }
    
    @objc func connected(_ sender : UIButton) {
        
        
        let buttonTag = sender.tag
        
        let indexPath = IndexPath(row: buttonTag, section: 0)
        let cell = CollectionView.cellForItem(at: indexPath) as! VideoCollectionViewCells
        //if(cell.playBtn.backgroundImage(for: .normal) == UIImage(named: "ic_play_icon")){
        if self.toggleState == 1{
            print("pause")
            cell.playBtn.setImage(UIImage(systemName:"pause.fill"), for: .normal)
            cell.player?.pause()
           // playing.play_id = 1
            self.toggleState = 2
            //cell.playBtn.isHidden = false
        }
        else if toggleState == 2{
           print("play")
            cell.playBtn.setImage(UIImage(systemName:"play.fill"), for: .normal)
            cell.player?.play()
            //playing.play_id = 0
            self.toggleState = 1
            //cell.playBtn.isHidden = true
        }
            
    
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        return CGSize(width: screenSize.width, height: screenSize.height)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let comedyCell = cell as? VideoCollectionViewCells {
            index = indexPath.row
            comedyCell.player?.play()
            comedyCell.image.isHidden = true
        
           // comedyCell.player!.addObserver(self, forKeyPath:"timeControlStatus", options: [.old, .new], context: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let comedyCell = cell as? VideoCollectionViewCells {
            index = indexPath.row
            comedyCell.player!.pause()
            
            
        }
    }
    
}
