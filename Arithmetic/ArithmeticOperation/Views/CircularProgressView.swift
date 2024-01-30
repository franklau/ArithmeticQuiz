//
//  CircularProgressView.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-29.
//

import UIKit

class CircularProgressView: UIView {

  private var progressRingLayer = RingLayer(color: .green)
  private var backgroundRingLayer = RingLayer(color: .lightGray)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(backgroundRingLayer)
    layer.addSublayer(progressRingLayer)
  }
  
  func updateProgress(_ progress: CGFloat) {
    progressRingLayer.strokeEnd = progress
    if progress < 0.1 {
      progressRingLayer.strokeColor = UIColor.red.cgColor
    } else {
      progressRingLayer.strokeColor = UIColor.green.cgColor
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    progressRingLayer.bounds = bounds
    backgroundRingLayer.bounds = bounds
  }
}
