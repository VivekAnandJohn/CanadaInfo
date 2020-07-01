//
//  AboutCanadaViewController.swift
//  CanadaInfo
//
//  Created by Vivek John on 01/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit
import Kingfisher

class AboutCanadaViewController: UIViewController {
    // tableview for displaying Canada details
    @IBOutlet var tableViewList: UITableView!
    
    //view model for fetching data
    var viewModel = AboutCanadaViewModel()
    
    // refresh control for tableview
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    // array stroing tableview data
    var listArray: [Row]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableViewList.addSubview(self.refreshControl)
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
    // tableview refresh controller
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        updateUI()
        refreshControl.endRefreshing()
    }
    
    // fetching service data and updating table view
    private func updateUI() {
        self.viewModel.getAboutCanadaDetails { [weak self] error in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                if error == nil {
                    strongSelf.listArray = self?.viewModel.rowModel
                    strongSelf.tableViewList.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableView

/*
 * View Controller extension for adding tableview functionality.
 * TableView will display the Canada Details
 */
extension AboutCanadaViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AboutListTableViewCell") as? AboutListTableViewCell {
            let item = listArray?[indexPath.row]
            cell.selectionStyle = .none
            cell.lblDescription.text = item?.desc
            cell.lblTitle.text = item?.title
            if let url = URL(string: item?.imagePath ?? "") {
            cell.imgIcon.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "default"))
            }
        return cell
        }
        return UITableViewCell()
    }

}
