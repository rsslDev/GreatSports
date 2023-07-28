//
//  PlayerDetailViewController.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import UIKit
import Kingfisher

class PlayerDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet var playerImageView: UIImageView!{
        didSet {
            playerImageView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var playerAgeLabel: UILabel!
    @IBOutlet weak var playerPriceLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerRatingLabel: UILabel!
    @IBOutlet weak var clubImageView: UIImageView!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    @IBOutlet weak var stackScrollView: UIScrollView!
    @IBOutlet weak var infoStackView: UIStackView!
    {
        didSet{
            for view in infoStackView.arrangedSubviews{
                
                let button = view as! UIButton
                //button.sizeToFit()
                button.backgroundColor = .white
                button.isSelected = false
                
                
            }
        }
    }
    private var playerDetailViewModel = PlayerDetailViewModel()
    
    internal var playerSlug:String = ""
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    var selectedInfoViewController:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let infoButton = infoStackView.arrangedSubviews[0] as? UIButton
        {
            infoButton.backgroundColor = UIColor(named: "PrimaryColor")
            infoButton.isSelected = true
        }
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        
        self.selectedInfoViewController?.view.frame = self.containerView.bounds
        DispatchQueue.main.async {
      
            let contentRect: CGRect = self.scrollView.subviews.reduce(into: .zero) { rect, view in
                rect = rect.union(view.frame)
            }
            self.scrollView.contentSize = contentRect.size
          
        }
        
        
        
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
     
       
        
        //DispatchQueue.main.async {
            if let child = container as? UIViewController {
               // self.containerView.frame.size.height = child.preferredContentSize.height
                self.containerViewHeightConstraint.constant = child.preferredContentSize.height
                self.containerView.layoutIfNeeded()
            }
        //}
      
    }
    
    @objc func backToListing() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    private func callAPI() {
        //playerImageView.image = nil
        self.view.activityStartAnimating(activityColor: UIColor.black, backgroundColor: UIColor.white.withAlphaComponent(0.5))
        playerDetailViewModel.fetchPlayerDetails(playerSlug: playerSlug) { entity in
            
        }
        playerDetailViewModel.playersDetailModel.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.setUpInterfaceWithData()
            }
        }
        
        playerDetailViewModel.isToShowLoader.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.view.activityStopAnimating()
            }
        }
    }
    
    private func setUpInterfaceWithData() {
        guard let playerDetail = playerDetailViewModel.playersDetailModel.value?.data else {
            return
        }
        addViewController(from: 0)
        playerNameLabel.text = playerDetail.playerName
        let mainPosition = playerDetail.indicators?.filter{$0.key == "Main position"}.first
        playerPositionLabel.text = mainPosition?.value
        if let validURL = playerDetail.playerPhoto {
            let fullURL = URL(string: validURL)
            playerImageView.kf.setImage(with: fullURL)
        }
        playerImageView.kf.indicatorType = .activity
        
        let age = playerDetail.indicators?.filter{$0.key == "Age"}.first
        playerAgeLabel.text = age?.value
        
        let marketPrice = playerDetail.indicators?.filter{$0.key == "Market price"}.first
        playerPriceLabel.text = marketPrice?.value
        
        let playerNumber = playerDetail.indicators?.filter{$0.key == "Player number"}.first
        playerNumberLabel.text = playerNumber?.value
        
        let rating = playerDetail.indicators?.filter{$0.key == "Rating"}.first
        playerRatingLabel.text = rating?.value
        
        if let validURL = playerDetail.teamPhoto {
            let fullURL = URL(string: validURL)
            clubImageView.kf.setImage(with: fullURL)
        }
        clubImageView.kf.indicatorType = .activity
        
        clubNameLabel.text = playerDetail.teamName
        countryLabel.text = playerDetail.playerCountry?.capitalized
        
        
        
    }
    
    @IBAction func selectInfoSection(_ sender: Any) {
        
        guard let selectedButton = sender as? UIButton else{
            return
        }
        
        infoStackView.arrangedSubviews.forEach {
            view in
            let button = view as! UIButton
            button.backgroundColor = .white
            button.isSelected = false
        }
        
        selectedButton.backgroundColor = UIColor(named: "PrimaryColor")
        selectedButton.isSelected = true
        
        addViewController(from: selectedButton.tag)
        
    }
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    private func addViewController(from viewTag:Int){
        if let viewController = selectedInfoViewController {
            remove(asChildViewController: viewController)
        }
        
        
        if viewTag == 0 {
            let childVC = PlayerInfoViewController(nibName: "PlayerInfoViewController", bundle: nil)
            childVC.playerDetailViewModel =  self.playerDetailViewModel
            self.selectedInfoViewController = childVC
            self.addChild(childVC)
            childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.containerView.addSubview(childVC.view)
            childVC.didMove(toParent: self)
            
          
        }
        else  if viewTag == 1 {
            let childVC = PlayerStatisticsViewController(nibName: "PlayerStatisticsViewController", bundle: nil)
            childVC.playerDetailViewModel =  self.playerDetailViewModel
            self.selectedInfoViewController = childVC
            self.addChild(childVC)
            childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.containerView.addSubview(childVC.view)
            childVC.didMove(toParent: self)
            
        }
        else  if viewTag == 2 {
            let childVC = PlayerEventsViewController(nibName: "PlayerEventsViewController", bundle: nil)
            childVC.playerDetailViewModel =  self.playerDetailViewModel
            self.selectedInfoViewController = childVC
            self.addChild(childVC)
            childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.containerView.addSubview(childVC.view)
            childVC.didMove(toParent: self)
            
        }
        else  if viewTag == 3 {
            let childVC = PlayerMediaListViewController(nibName: "PlayerMediaListViewController", bundle: nil)
            childVC.playerDetailViewModel =  self.playerDetailViewModel
            self.selectedInfoViewController = childVC
            self.addChild(childVC)
            
            childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.containerView.addSubview(childVC.view)
            childVC.didMove(toParent: self)
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
