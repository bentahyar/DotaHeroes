//
//  RolesCell.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import UIKit

class RolesCell: UICollectionViewCell {
    @IBOutlet weak var roleLabel: UILabel!

    var role: String = "" {
        didSet {
            didSetRole()
        }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.roleLabel.backgroundColor = .gray
                self.roleLabel.textColor = .white
            } else {
                self.roleLabel.backgroundColor = .white
                self.roleLabel.textColor = .black
            }
        }
    }

    static func getCellSize(withText text: String) -> CGSize {
        let font = UIFont.systemFont(ofSize: 10)
        let textWidth = text.size(withAttributes: [.font: font]).width + 30.0
        return CGSize(width: textWidth, height: 30)
    }

    static func reuseIdentifier() -> String {
        return "RolesCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }

    private func didSetRole() {
        roleLabel.text = role.uppercased()
    }
}
