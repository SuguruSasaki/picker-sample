//
//  ViewSubviews.swift
//  PickerSample
//
//  Created by sugurusasaki on 2019/02/15.
//  Copyright © 2019 sugurusasaki. All rights reserved.
//

import UIKit
import SnapKit

final class ViewSubviews{

    // A
    lazy var dateTF_A: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.gray
        tf.text = "yahooo"
        return tf
    }()
    
    // B
    lazy var dateTF_B: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.gray
        return tf
    }()
    
    // C
    lazy var dateTF_C: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.gray
        return tf
    }()

    
    /// UIDatePicker
    lazy var viewDatePicker: UICustomDatePicker = {
        let view = UICustomDatePicker()
        return view
    }()
    
    
    /// Subiviewsの制約を更新
    ///
    /// - Parameter viewController: instance of UIViewController
    /// - Returns: Void
    func updateSubviewsConstraints(viewController: UIViewController) {
        
        self.dateTF_A.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-60)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        self.dateTF_B.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-60)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.dateTF_C.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-60)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
        }
    }
}
