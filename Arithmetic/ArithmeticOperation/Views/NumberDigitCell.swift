//
//  NumberDigitCell.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-28.
//

import UIKit

class NumberDigitCell: UICollectionViewCell {

  static let reuseIndentifier = String(describing: NumberDigitCell.self)
  static let nibName = String(describing: NumberDigitCell.self)
  @IBOutlet weak var label: UILabel!
  
  let cornerRadius = 15.0
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contentView.backgroundColor = .yellow
    
    contentView.layer.cornerRadius = cornerRadius
    contentView.layer.masksToBounds = true
    
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 5)
    layer.shadowRadius = 3
    layer.shadowOpacity = 0.5
    layer.masksToBounds = false
  }
  
  func updateText(_ text: String, backgroundColor: UIColor) {
    label.text = text
    contentView.backgroundColor = backgroundColor
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    
  }
}
