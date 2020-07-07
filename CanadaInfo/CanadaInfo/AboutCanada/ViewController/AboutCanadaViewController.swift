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
    
    //label for displaying page title
    @IBOutlet var lblTitle: UILabel!
    
    //view model for fetching data
    var viewModel = AboutCanadaViewModel()
    
    // refresh control for tableview
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewList.addSubview(refreshControl)
        updateUI()
    }
    
    // tableview refresh controller
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        updateUI()
        refreshControl.endRefreshing()
    }
    
    // fetching service data and updating table view
    func updateUI() {
        if currentReachabilityStatus == .notReachable {
            self.refreshControl.endRefreshing()
            DispatchQueue.main.async {
                Alert.present(title: Alert.Network.title,
                              message: Alert.Network.message,
                              actions: .retry(handler: {
                                self.updateUI()
                              }), .close,
                                  from: self)
            }
        } else {
            self.viewModel.getAboutCanadaDetails { error in
                if let error = error {
                    Alert.present(title: Alert.Network.title,
                                  message: error.localizedDescription,
                                  actions: .close,
                                      from: self)
                }
                self.lblTitle.text = self.viewModel.titleString
                self.tableViewList.reloadData()
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
        return self.viewModel.rowModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AboutListTableViewCell") as? AboutListTableViewCell {
            cell.selectionStyle = .none
            cell.lblTitle.text = ""
            cell.lblDescription.text = ""
            cell.imgIcon.image = #imageLiteral(resourceName: "default")
            if let item = self.viewModel.rowModel {
                cell.configure(item: item[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
}
