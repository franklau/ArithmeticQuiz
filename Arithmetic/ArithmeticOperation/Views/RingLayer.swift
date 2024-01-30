//
//  RingLayer.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-29.
//

import UIKit

class RingLayer: CAShapeLayer {
  
  let lineThickness = 5.0
  
  init(color: UIColor) {
    super.init()
    strokeColor = color.cgColor
    lineWidth = lineThickness
    lineCap = .round
    fillColor = nil
  }
  
  override var bounds: CGRect {
    didSet {
      buildLayer()
    }
  }
  
  override init(layer: Any) {
    super.init(layer: layer)
  }
  
  private func buildLayer() {
    let radius = bounds.width / 2.0 - lineWidth / 2.0
    let x = bounds.width / 2.0
    let y = bounds.height / 2.0
    
    let startAngle = 3 * CGFloat.pi / 2
    let endAngle = startAngle + 2 * CGFloat.pi
    
    path = UIBezierPath(arcCenter: CGPoint(x: x, y: y),
                            radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: true).cgPath
    position = CGPoint(x: bounds.midX, y: bounds.midY)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
