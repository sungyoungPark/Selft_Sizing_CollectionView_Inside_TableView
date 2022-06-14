//
//  ViewController.swift
//  CollectionViewInsideTableView
//
//  Created by 박성영 on 2022/06/14.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")

        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.row == 5 {
            cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
            cell?.textLabel?.text = "Row \(indexPath.row)"
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension UITableView {
    func updateRowHeightsWithoutReloadingRows(animated: Bool = false) {
        let block = {
            self.beginUpdates()
            self.endUpdates()
        }
        
        if animated {
            block()
        }
        else {
            UIView.performWithoutAnimation {
                block()
            }
        }
    }
}
