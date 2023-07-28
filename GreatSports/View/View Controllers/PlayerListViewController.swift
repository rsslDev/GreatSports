//
//  PlayerListViewController.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import UIKit
import Kingfisher

class PlayerListViewController: UIViewController {

    @IBOutlet private var playersTableView: UITableView! {
        didSet {
            // Configure Table View
            playersTableView.delegate = self
            playersTableView.dataSource = self
            playersTableView.showsVerticalScrollIndicator = false
            
            // Register Table View Cell
            
            playersTableView.register(UINib(nibName: "PlayerListTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerListTableViewCell")
        }
    }
    
    @IBOutlet private var playersCollectionView: UICollectionView! {
        didSet {
            playersCollectionView.dataSource = self
            playersCollectionView.delegate = self

            playersCollectionView.register(UINib(nibName: "PlayerListCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PlayerListCollectionViewCell")
        }
    }
    private var playerViewModel = PlayerListViewModel()
    var allList: [Player] = []
    var filteredList: [Player] = []
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Great Sports"
        setUpInterface()
        UINavigationBar.appearance().tintColor = UIColor.white
        self.playersTableView.keyboardDismissMode = .onDrag
    }

    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.tableViewHeightConstraint.constant = self.playersTableView.contentSize.height
            self.playersTableView.setNeedsLayout()
            self.playersTableView.layoutIfNeeded()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callAPI()
    }
    
    
    private func setUpInterface() {
        playersTableView.rowHeight = UITableView.automaticDimension
        playersTableView.estimatedRowHeight = 100
        
    }
    
    
    private func callAPI() {
        self.view.activityStartAnimating(activityColor: UIColor.black, backgroundColor: UIColor.white.withAlphaComponent(0.5))
        
        playerViewModel.fetchPlayerList(params: [:]) { onComplete in
            
        }
        playerViewModel.playersListModel.bind { [weak self] newsModel in
            DispatchQueue.main.async {
                
                self?.allList =  self?.playerViewModel.playersListModel.value?.data ?? []
                self?.filteredList.removeAll()
                self?.playersTableView.reloadData()
                self?.playersCollectionView.reloadData()
            }
        }
        playerViewModel.isToShowLoader.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.view.activityStopAnimating()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayerListViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredList.count > 0{
            return filteredList.count
        }
        if playerViewModel.playersListModel.value == nil {
            return 0
        }
        return playerViewModel.playersListModel.value?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerListTableViewCell") as? PlayerListTableViewCell else {
            return UITableViewCell()
        }
        guard let dataObject = playerViewModel.playersListModel.value?.data?[indexPath.row] else {
            return UITableViewCell()
        }
        
       
        if let validURL = dataObject.photo {
            let fullURL = URL(string:validURL)
            cell.playerImageView.kf.setImage(with: fullURL)
        }
        cell.playerImageView.kf.indicatorType = .activity
        cell.playerNameLabel.text = dataObject.name
        cell.playerPositionLabel.text = dataObject.positionName
        cell.playerRatingLabel.text = dataObject.rating
        cell.playerTeamNameLabel.text = dataObject.teamName
        
        return cell
    }
    
    
}

extension PlayerListViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let dataObject = playerViewModel.playersListModel.value?.data?[indexPath.row] else {
            return
        }
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerDetailViewController") as? PlayerDetailViewController {
            vc.playerSlug = String(dataObject.slug ?? "")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension PlayerListViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if playerViewModel.playersListModel.value == nil {
            return 0
        }
        return playerViewModel.playersListModel.value?.data?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        0
//    }
//
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerListCollectionViewCell", for: indexPath) as? PlayerListCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let dataObject = playerViewModel.playersListModel.value?.data?[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        if let validURL = dataObject.photo {
            let fullURL = URL(string:validURL)
            collectionViewCell.playerImageView.kf.setImage(with: fullURL)
        }
        collectionViewCell.playerImageView.kf.indicatorType = .activity
        
        collectionViewCell.playerNameLabel.text = dataObject.name
        collectionViewCell.playerTeamNameLabel.text = dataObject.teamName

        
        return collectionViewCell
        
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 156, height: 206)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let dataObject = playerViewModel.playersListModel.value?.data?[indexPath.row] else {
            return
        }
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerDetailViewController") as? PlayerDetailViewController {
            vc.playerSlug = String(dataObject.slug ?? "")
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
