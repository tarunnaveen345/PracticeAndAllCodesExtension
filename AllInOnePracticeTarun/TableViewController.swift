//
//  TableViewController.swift
//  AllInOnePracticeTarun
//
//  Created by tarun naveen on 26/07/18.
//  Copyright © 2018 tarun naveen. All rights reserved.
//

import UIKit
import VGPlayer
import SnapKit



class TableViewController: UITableViewController {

    @IBOutlet weak var vieww: UIView!
    
    var player = VGPlayer()
    var url : URL?
    
    var HeaderView : UIView!
    var NewHeaderLayer : CAShapeLayer!
    
    private let HeaderHeight : CGFloat = 470
    private let HeaderCut : CGFloat = 50
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        
        let url = URL(string: "http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8")
        if url != nil {
            player = VGPlayer(URL: url!)
        }
        player.delegate = self
        view.addSubview((player.displayView))
        player.backgroundMode = .proceed
        player.play()
        player.displayView.delegate = self
        player.displayView.titleLabel.text = "HLS Live"
        player.displayView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.edges.equalTo(strongSelf.view)
        }
        
        
        
        
        
        
        updateView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func updateView(){
        
        tableView.backgroundColor = UIColor.white
        HeaderView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(HeaderView)
        
        NewHeaderLayer = CAShapeLayer()
        NewHeaderLayer.fillColor = UIColor.black.cgColor
        HeaderView.layer.mask = NewHeaderLayer
        
        
        let newheight = HeaderHeight - HeaderCut/2
        tableView.contentInset = UIEdgeInsets(top: newheight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0 , y: -newheight)
        
        Setupnewview()
        
    }
    func Setupnewview()
    {
        let newheight = HeaderHeight - HeaderCut/2
        var getheaderframe = CGRect(x: 0, y: -newheight, width: tableView.bounds.width, height: HeaderHeight)
        if tableView.contentOffset.y < newheight
        {
           getheaderframe.origin.y = tableView.contentOffset.y
           getheaderframe.size.height = -tableView.contentOffset.y + HeaderCut/2
        }
        
        HeaderView.frame = getheaderframe
        let cutdirection = UIBezierPath()
        cutdirection.move(to: CGPoint(x: 0, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: getheaderframe.height))
        cutdirection.addLine(to: CGPoint(x: 0, y: getheaderframe.height - HeaderCut))
        NewHeaderLayer.path = cutdirection.cgPath
 
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 230
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        cell.celImageview.image = #imageLiteral(resourceName: "champa.jpg")
        cell.cellLabel.text = "Vamsi bhaya restuarent"
        
        
        
        
        // Configure the cell...

        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.Setupnewview()
        
        
        
        
        
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        var offset = scrollView.contentOffset.y / 150
        
        if offset > 1
        {
              offset = 1
            

            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1 )
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            UIApplication.shared.statusBarView.backgroundColor = color
            
        }
        else
        {
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1 )
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            UIApplication.shared.statusBarView.backgroundColor = color
        }

        
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension TableViewController: VGPlayerDelegate {
    func vgPlayer(_ player: VGPlayer, playerFailed error: VGPlayerError) {
        print(error)
    }
    func vgPlayer(_ player: VGPlayer, stateDidChange state: VGPlayerState) {
        print("player State ",state)
    }
    func vgPlayer(_ player: VGPlayer, bufferStateDidChange state: VGPlayerBufferstate) {
        print("buffer State", state)
    }
    
}

extension TableViewController: VGPlayerViewDelegate {
    func vgPlayerView(_ playerView: VGPlayerView, willFullscreen fullscreen: Bool) {
        
    }
    func vgPlayerView(didTappedClose playerView: VGPlayerView) {
        if playerView.isFullScreen {
            playerView.exitFullscreen()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func vgPlayerView(didDisplayControl playerView: VGPlayerView) {
        UIApplication.shared.setStatusBarHidden(!playerView.isDisplayControl, with: .fade)
    }
}



