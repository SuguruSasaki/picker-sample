//
//  Tweener.swift
//  OSHARE_NAVI_CART
//
//  Created by SuguruSasaki on 2018/02/17.
//  Copyright © 2018年 quad. All rights reserved.
//


import Foundation
import UIKit
import RxSwift

final class Tweener {
    /// Tweenインスタンスを格納するDictionary
    private static var tweens:[Int:Tween] = [:]
}

// MARK: - I/F
extension Tweener {
    
    /// Tween追加
    ///
    /// - Parameters:
    ///   - duration: 0.5
    ///   - closure: 具体的なアニメーション内容
    @discardableResult
    static func addTween(with duration: TimeInterval, closure:@escaping () -> () ) -> Tween{
        let index = tweens.count
        let tween = Tween(duration: duration, closure: closure, completion: {
            Tweener.removeAtIndexTween(index: index)
        })
        tweens[index] = tween
        tween.start()
        return tween
    }
    
    /// すべてのTweenを削除する
    static func killAllTweens() -> Void {
        tweens.forEach { (key, tween) in
            tween.stop()
            tweens.removeValue(forKey: key)
        }
    }
}

// MARK: - Private
private extension Tweener {
    
    /// 削除
    ///
    /// - Parameter index: 保存しているDictionaryのKey
    static func removeAtIndexTween(index: Int) -> Void {
        tweens.removeValue(forKey: index)
    }
}

