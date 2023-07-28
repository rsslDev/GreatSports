//
//  PlayerEventsViewController.swift
//  GreatSports
//
//  Created by Russel Dev on 26/07/23.
//

import UIKit

class PlayerEventsViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var playerDetailViewModel = PlayerDetailViewModel()
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            // Configure Table View
            tableView.delegate = self
            tableView.dataSource = self
            tableView.showsVerticalScrollIndicator = false
            
            // Register Table View Header
            
            tableView.register(UINib(nibName: "PlayerMatchHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "PlayerMatchHeaderView")
            // Register Table View Cell
            
            tableView.register(UINib(nibName: "PlayerMatchTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerMatchTableViewCell")
        }
    }
    
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.reloadData()
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

extension PlayerEventsViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if playerDetailViewModel.playersDetailModel.value == nil {
            return 0
        }
        return playerDetailViewModel.playersDetailModel.value?.data?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if playerDetailViewModel.playersDetailModel.value == nil {
            return 0
        }
        return playerDetailViewModel.playersDetailModel.value?.data?.events?[section].matches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 42
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataObject = playerDetailViewModel.playersDetailModel.value?.data?.events?[section] as? Event else {
            return UITableViewHeaderFooterView()
            
        }
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PlayerMatchHeaderView") as! PlayerMatchHeaderView
        if let validURL = dataObject.leagueLogo {
            let fullURL = URL(string:validURL)
            headerView.matchLeagueImageView.kf.setImage(with: fullURL)
        }
        headerView.matchLeagueImageView.kf.indicatorType = .activity
        headerView.matchLeagueNameLabel.text = dataObject.leagueName
        return headerView
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerMatchTableViewCell") as? PlayerMatchTableViewCell else {
            return UITableViewCell()
        }
        guard let dataObject = playerDetailViewModel.playersDetailModel.value?.data?.events?[indexPath.section] as? Event ,let match = dataObject.matches?[indexPath.row] else {
            return UITableViewCell()
            
        }
        
       
        cell.matchDateLabel.text = match.date
        cell.matchRoundLabel.text = match.round?.split(separator: "").last?.lowercased()
        cell.homeTeamNameLabel.text = match.homeName
        cell.awayTeamNameLabel.text = match.awayName
        cell.homeTeamScoreLabel.text = match.homeScore
        cell.awayTeamScoreLabel.text = match.awayScore
        
        return cell
    }
    
    
}
