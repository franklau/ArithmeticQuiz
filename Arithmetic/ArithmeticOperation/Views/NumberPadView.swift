//
//  NumberPadView.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-28.
//

import UIKit

protocol NumberPadViewDelegate: AnyObject {
  func numberPadDidSelect(number: Int)
  func numberPadDidEnter()
}

class NumberPadView: UIView {
  
  weak var delegate: NumberPadViewDelegate?
  
  enum NumberPadValue: Equatable {
    case numeric(value: Int)
    case enter
    
    var displayText: String {
      switch self {
      case .numeric(let value):
        return String(value)
        
      case .enter:
        return "Enter"
      }
    }
    
    static func==(lhs: Self, rhs: Self) -> Bool {
      switch (lhs, rhs) {
      case let (.numeric(lhsValue), .numeric(value: rhsValue)):
        return lhsValue == rhsValue
      case (.enter, .enter):
        return true
      default:
        return false
      }
    }
  }
  
  let numRows = 4
  let numItemsPerRow = 3
  let interItemSpacing = 10.0
  let lineSpacing = 10.0
  
  let numPadValues: [NumberPadValue] = {
    return [9, 8, 7, 4, 5, 6, 1, 2, 3, 0].map { .numeric(value: $0) } + [.enter]
  }()
  
  init(bounds: CGRect) {
    super.init(frame: .zero)
    self.addSubview(collectionView)
    collectionView.pin(to: self)
    let numberNib = UINib(nibName: NumberDigitCell.nibName, bundle: nil)
    collectionView.register(numberNib, forCellWithReuseIdentifier: NumberDigitCell.nibName)
    collectionView.clipsToBounds = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var collectionView: UICollectionView  = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  
}

extension NumberPadView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let totalWidth = bounds.width
    let totalHeight = bounds.height
    
    let totalHorizontalSpacing = interItemSpacing * CGFloat(numItemsPerRow - 1)
    let cellWidth = (totalWidth - totalHorizontalSpacing) / Double(numItemsPerRow)
    
    let totalVerticalSpacing = lineSpacing * CGFloat(numRows - 1)
    let cellHeight = (totalHeight - totalVerticalSpacing) / CGFloat(numRows)
    
    if indexPath.row < numPadValues.count - 1 {
      return CGSize(width: cellWidth, height: cellHeight)
    } else  {
      let enterCellWidth = totalWidth - interItemSpacing - cellWidth // takes up 2 spaces
      return CGSize(width: enterCellWidth, height: cellHeight)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let numPadValue = numPadValues[indexPath.row]
    switch numPadValue {
    case .numeric(value: let value):
      delegate?.numberPadDidSelect(number: value)
    case .enter:
      delegate?.numberPadDidEnter()
    }
  }
}

extension NumberPadView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberDigitCell.reuseIndentifier,
                                                  for: indexPath) as! NumberDigitCell
    let pinPadValue = numPadValues[indexPath.row]
    if pinPadValue == .enter {
      cell.updateText(pinPadValue.displayText, backgroundColor: UIColor.confirmButton)
    } else {
      cell.updateText(pinPadValue.displayText, backgroundColor: UIColor.secondaryButton)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numPadValues.count
  }
}
