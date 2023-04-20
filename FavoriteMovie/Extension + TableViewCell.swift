//
//  Extension + TableView.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/20.
//

import Foundation

extension UITableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
