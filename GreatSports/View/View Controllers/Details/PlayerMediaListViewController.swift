//
//  PlayerMediaListViewController.swift
//  GreatSports
//
//  Created by Russel Dev on 26/07/23.
//

import UIKit
import Kingfisher

class PlayerMediaListViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var playerDetailViewModel = PlayerDetailViewModel()    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            // Configure Table View
            tableView.delegate = self
            tableView.dataSource = self
            tableView.showsVerticalScrollIndicator = false
            
            // Register Table View Cell
            
            tableView.register(UINib(nibName: "PayerMediaTableViewCell", bundle: nil), forCellReuseIdentifier: "PayerMediaTableViewCell")
        }
    }
    
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        // Do any additional setup after loading the view.
    }


    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        
            self.tableView.layoutIfNeeded()
            self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
            self.tableView.setNeedsLayout()
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

extension PlayerMediaListViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if playerDetailViewModel.playersDetailModel.value == nil {
            return 0
        }
        return playerDetailViewModel.playersDetailModel.value?.data?.medias?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PayerMediaTableViewCell") as? PayerMediaTableViewCell else {
            return UITableViewCell()
        }
        guard let dataObject = playerDetailViewModel.playersDetailModel.value?.data?.medias?[indexPath.row] as? Media else {
            return UITableViewCell()
            
        }
        
       
        if let validURL = dataObject.preview {
            let fullURL = URL(string:validURL)
            cell.mediaImageView.kf.setImage(with: fullURL)
        }
        cell.mediaImageView.kf.indicatorType = .activity
        cell.dateLabel.text = dataObject.date
        cell.mediaTitleLabel.text = dataObject.title
        cell.mediaDescriptionLabel.text = dataObject.subtitle
        return cell
    }
    
    
}

extension PlayerMediaListViewController:UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 309
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
}
