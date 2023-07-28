//
//  PlayerStatisticsViewController.swift
//  GreatSports
//
//  Created by Russel Dev on 26/07/23.
//

import UIKit

class PlayerStatisticsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var playerDetailViewModel = PlayerDetailViewModel()
    var selectedSection = 0
    @IBOutlet weak var totalPlayedLabel: UILabel!
    @IBOutlet weak var startedLabel: UILabel!
    @IBOutlet weak var minuterPerGameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            // Configure Table View
            //tableView.delegate = self
            tableView.dataSource = self
            tableView.showsVerticalScrollIndicator = false
            tableView.rowHeight = 26
            
            // Register Table View Cell
            
            tableView.register(UINib(nibName: "PlayerInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerInfoTableViewCell")
        }
    }
    
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self

            collectionView.register(UINib(nibName: "PlayerLeaguesCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PlayerLeaguesCollectionViewCell")
        }
    }
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
      reloadView()
        
        // Do any additional setup after loading the view.
    }
    
    private func reloadView(){
        if let leagueMatchDetails =  playerDetailViewModel.playersDetailModel.value?.data?.statistics?[selectedSection].data?.filter({$0.section == "Matches"}).first?.data {
            
            if let totalPlayedMatch = leagueMatchDetails.filter({$0.key == "Total played"}).first{
                totalPlayedLabel.text = totalPlayedMatch.value

            }
            if let started = leagueMatchDetails.filter({$0.key == "Started"}).first{
                startedLabel.text = started.value

            }
            if let minuterPerGame = leagueMatchDetails.filter({$0.key == "Minutes per game"}).first{
                minuterPerGameLabel.text = minuterPerGame.value

            }
           
            
        }
        self.collectionView.reloadData()
        self.tableView.reloadData()
        self.view.layoutIfNeeded()
    }
    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        
       
     
        self.tableView.layoutIfNeeded()
            self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
            let contentRect: CGRect = self.scrollView.subviews.reduce(into: .zero) { rect, view in
                rect = rect.union(view.frame)
            }
            self.scrollView.contentSize = contentRect.size
      
     
        
    }

    override func viewDidAppear(_ animated: Bool) {
        let contentRect: CGRect = self.scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        
        self.scrollView.contentSize = contentRect.size
        self.preferredContentSize.height = contentRect.size.height
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


extension PlayerStatisticsViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if playerDetailViewModel.playersDetailModel.value == nil {
            return 0
        }
        
        return playerDetailViewModel.playersDetailModel.value?.data?.statistics?[selectedSection].data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if playerDetailViewModel.playersDetailModel.value == nil {
            return ""
        }
        return playerDetailViewModel.playersDetailModel.value?.data?.statistics?[selectedSection].data?[section].section
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = .white
            view.textLabel?.font = UIFont.systemFont(ofSize: 28, weight: .light)
            view.textLabel?.textAlignment = .center
            view.textLabel?.backgroundColor = .white
            view.textLabel?.textColor = UIColor(named: "PrimaryMildColor")
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playerDetailViewModel.playersDetailModel.value == nil {
            return 0
        }
        return playerDetailViewModel.playersDetailModel.value?.data?.statistics?[selectedSection].data?[section].data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerInfoTableViewCell") as? PlayerInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        guard let dataObject = playerDetailViewModel.playersDetailModel.value?.data?.statistics?[selectedSection].data?[indexPath.section], let statistic = dataObject.data?[indexPath.row]  else {
            return UITableViewCell()
        }
        
        cell.infoTitleLabel.text = statistic.key
        cell.infoValueLabel.text = statistic.value
       
        
        return cell
    }
    
    
}



extension PlayerStatisticsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if playerDetailViewModel.playersDetailModel.value == nil {
            return 0
        }
        return playerDetailViewModel.playersDetailModel.value?.data?.statistics?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        0
//    }
//
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerLeaguesCollectionViewCell", for: indexPath) as? PlayerLeaguesCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let dataObject = playerDetailViewModel.playersDetailModel.value?.data?.statistics?[indexPath.row] else {
            return UICollectionViewCell()
        }
        
      
            collectionViewCell.leagueTitleLabel.textColor = indexPath.row == selectedSection ? UIColor(named: "PrimaryColor"):UIColor(named: "Gray08Color")
            collectionViewCell.selectedView.backgroundColor = indexPath.row == selectedSection ?UIColor(named: "PrimaryColor") : .white
        collectionViewCell.leagueTitleLabel.text = dataObject.league
      

        
        return collectionViewCell
        
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 180, height: 40)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedSection = indexPath.row
        reloadView()
       
        
    }
}

