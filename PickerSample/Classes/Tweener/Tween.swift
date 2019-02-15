//
//  Tween.swift
//  OSHARE_NAVI_CART
//
//  Created by SuguruSasaki on 2018/02/17.
//  Copyright © 2018年 quad. All rights reserved.
//

import Foundation
import UIKit

final class Tween {
    
    private let animator:UIViewPropertyAnimator
    
    /// 初期化
    init(duration: TimeInterval, closure: @escaping () -> (), completion: @escaping () -> () ) {
        let timing = UICubicTimingParameters(animationCurve: .easeOut)
        self.animator = UIViewPropertyAnimator(duration: duration, timingParameters: timing)
        self.animator.addAnimations {
            closure()
        }
        self.animator.addCompletion { (positon) in
            if positon == .end {  completion() }
        }
    }
}

// MARK: I/F
extension Tween {
    
    func start() -> Void {
        self.animator.startAnimation()
    }
    
    func stop() -> Void {
        self.animator.stopAnimation(false)
    }
    
}


