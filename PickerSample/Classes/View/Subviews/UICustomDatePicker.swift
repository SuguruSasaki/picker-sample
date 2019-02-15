//
//  UIDatePicker.swift
//  PickerSample
//
//  Created by sugurusasaki on 2019/02/15.
//  Copyright © 2019 sugurusasaki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class UICustomDatePicker: UIView {
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    /// 閉じるボタン
    lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Close"
        button.titleLabel?.textColor = .black
        button.sizeToFit()
        button.backgroundColor = .blue
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: -20)
        return button
    }()
    
    /// DatePicker
    lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        view.backgroundColor = .white
        view.datePickerMode = .date
        return view
    }()
    
    /// 初期化
    init() {
        super.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 300))
        self.backgroundColor = UIColor.white
        self.addSubview(self.datePicker)
        self.addSubview(self.buttonClose)
    }
    
}


// MARK: - Life cycle
extension UICustomDatePicker {
    /// 制約
    override func updateConstraints() {
        
        self.buttonClose.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
        }
        
        super.updateConstraints()
    }
}

extension UICustomDatePicker {
    
    var onModeChange: Binder<UIDatePicker.Mode> {
        return Binder(self) { (view, mode) in
            view.datePicker.datePickerMode = mode
        }
    }
    
    var onChange: Binder<Date> {
        return Binder(self) { (view, date) in
            view.datePicker.date = date
        }
    }
    
    var isActive: Binder<Bool> {
        return Binder(self) { (view, bool) in
            
            if bool {
                Tweener.addTween(with: 0.4, closure: {
                    view.transform = CGAffineTransform(translationX: 0, y: -300)
                })
            } else {
                Tweener.addTween(with: 0.4, closure: {
                    view.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            }
        }
    }
}
