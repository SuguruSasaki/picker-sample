//
//  ViewController.swift
//  PickerSample
//
//  Created by sugurusasaki on 2019/02/15.
//  Copyright © 2019 sugurusasaki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class ViewController: UIViewController, View  {
    typealias Reactor = ViewReactor
    
    var disposeBag = DisposeBag()
    
    private let subviews: ViewSubviews = ViewSubviews()
    
    // 画面に表示するView要素を生成しているだけです。
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.subviews.dateTF_A)
        self.view.addSubview(self.subviews.dateTF_B)
        self.view.addSubview(self.subviews.dateTF_C)
        self.view.addSubview(self.subviews.viewDatePicker)
        
        // Reactorインスタンス "self.reactor"に渡すと bind(reactor: Reactor)が実行されます。
        self.reactor = ViewReactor()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.subviews.updateSubviewsConstraints(viewController: self)
    }
    
    
    // bindメソッド内で、reactorと各View要素をbindします。
    func bind(reactor: ViewController.Reactor) {
        
        // ExtensionでUITextFieldにrx機能を追加しています。
        self.subviews.dateTF_A.ex.tap
            .map { _ in return Reactor.Action.tap(Reactor.InputType.A) } // tapから値が飛んできますが、利用しないので無視して、代わりにActionを発行します。
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.subviews.dateTF_B.ex.tap
            .map { _ in Reactor.Action.tap(Reactor.InputType.B) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.subviews.dateTF_C.ex.tap
            .map { _ in Reactor.Action.tap(Reactor.InputType.C) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        
        // Pickerの閉じるボタンタップ時に通知します。
        self.subviews.viewDatePicker.buttonClose.rx.tap
            .map { Reactor.Action.tapPickerClose}
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // DatePickerのdateを監視
        self.subviews.viewDatePicker.datePicker.rx.date
            .skip(1) // 初回スキップしていますが、なしでも問題ないです。
            .map { Reactor.Action.changeDateA($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // Reactorからの変更を受け取ります。
        reactor.state
            .map { $0.isPicker }
            .bind(to: self.subviews.viewDatePicker.isActive)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .skip(1) // 初回スキップしていますが、なしでも問題ないです。
            .map { $0.str_A }
            .bind(to: self.subviews.dateTF_A.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .skip(1) // 初回スキップしていますが、なしでも問題ないです。
            .map { $0.str_B }
            .bind(to: self.subviews.dateTF_B.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .skip(1) // 初回スキップしていますが、なしでも問題ないです。
            .map { $0.str_C }
            .bind(to: self.subviews.dateTF_C.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isTimePicker ? UIDatePicker.Mode.time : UIDatePicker.Mode.date }
            .bind(to: self.subviews.viewDatePicker.onModeChange)
            .disposed(by: self.disposeBag)
    }
}

