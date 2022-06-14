//
//  TableViewCell.swift
//  CollectionViewInsideTableView
//
//  Created by 박성영 on 2022/06/14.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var collectionView : CustomCollectionView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCollectionView()
    }
    
    func setTableViewCell(){
        
        
    }
    
    func initCollectionView() {
        
        let flowLayOut = UICollectionViewFlowLayout()
        flowLayOut.scrollDirection = .vertical
        
        collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: flowLayOut)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.didLayoutAction = updateRowHeight
        
        collectionView.backgroundColor = .blue
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.bottom.equalTo(0)
        }
        
    }
    
    private func updateRowHeight() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.updateRowHeightsWithoutReloadingRows()
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return collectionView.contentSize
    }

    
}


extension TableViewCell : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .lightGray
    
        return cell
    }
    
}

extension UIView {
    var parentViewController: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.parentViewController
        } else {
            return nil
        }
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return (next as? UITableView) ?? (parentViewController as? UITableViewController)?.tableView
    }
}


class CustomCollectionView : UICollectionView {
    
    var didLayoutAction: (() -> Void)?
    
    override func draw(_ rect: CGRect) {
        print("draw end")
        
        didLayoutAction?()
        didLayoutAction = nil   //  Call only once
    }
}
