//TableViewExtension.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/20/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit

public extension UITableView {

    func registerCellClass(_ cellClass: AnyClass) {

        let identifier = String(describing: cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }

    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String(describing: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewClass(_ viewClass: AnyClass) {
        let identifier = String(describing: viewClass)
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewNib(_ viewClass: AnyClass) {
        let identifier = String(describing: viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func reloadData(completion: @escaping () -> Void) {
        self.reloadData()
        DispatchQueue.main.async {
            completion()
        }
    }

}

public extension UICollectionView {

    func registerCellClass(_ cellClass: AnyClass) {

        let identifier = String(describing: cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String(describing: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }

    func reloadData(completion: @escaping () -> Void) {
        self.reloadData()
        jcPrint("options reloaded")
        DispatchQueue.main.async {
            completion()
        }
    }

    func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool, completion: @escaping () -> Void) {

        self.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
        DispatchQueue.main.async {
            completion()
        }
    }

}
