//
//  PlayerInfoViewController.swift
//  GreatSports
//
//  Created by Russel Dev on 26/07/23.
//

import UIKit

class PlayerInfoViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var playerDetailViewModel = PlayerDetailViewModel()
    @IBOutlet weak var infoLabel: UILabel!
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
    
    @IBOutlet weak var ratingsTableView: UITableView!
    {
        didSet {
            // Configure Table View
            //tableView.delegate = self
            ratingsTableView.dataSource = self
            ratingsTableView.showsVerticalScrollIndicator = false
            
            // Register Table View Cell
            
            ratingsTableView.register(UINib(nibName: "PlayerInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerInfoTableViewCell")
        }
    }
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var ratingTableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.text = playerDetailViewModel.playersDetailModel.value?.data?.about
        
        
        

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        
       
            self.tableView.layoutIfNeeded()
            self.ratingsTableView.layoutIfNeeded()
            self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
            self.ratingTableViewHeightConstraint.constant = self.ratingsTableView.contentSize.height
            let contentRect: CGRect = self.scrollView.subviews.reduce(into: .zero) { rect, view in
                rect = rect.union(view.frame)
            }
            self.scrollView.contentSize = contentRect.size
      
     
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.preferredContentSize.height = self.scrollView.contentSize.height
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

extension PlayerInfoViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 26
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ratingsTableView{
            if playerDetailViewModel.playersDetailModel.value?.data?.rating == nil {
                return 0
            }
            return playerDetailViewModel.playersDetailModel.value?.data?.rating?.count ?? 0
        }
        else {
            if playerDetailViewModel.playersDetailModel.value?.data?.indicators == nil {
                return 0
            }
            return playerDetailViewModel.playersDetailModel.value?.data?.indicators?.count ?? 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerInfoTableViewCell") as? PlayerInfoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        if tableView == ratingsTableView{
            guard let dataObject = playerDetailViewModel.playersDetailModel.value?.data?.rating?[indexPath.row] as? Indicator else {
                return UITableViewCell()
                
            }
            
          
            cell.infoTitleLabel.text = dataObject.key
            cell.infoValueLabel.text = dataObject.value
        }
        else {
            guard let dataObject = playerDetailViewModel.playersDetailModel.value?.data?.indicators?[indexPath.row] as? Indicator else {
                return UITableViewCell()
                
            }
            
          
            cell.infoTitleLabel.text = dataObject.key
            cell.infoValueLabel.text = dataObject.value
        }
      
        
        return cell
    }
    
    
}
