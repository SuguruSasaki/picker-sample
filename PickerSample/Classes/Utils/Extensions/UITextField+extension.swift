//
//  TextField+extension.swift
//  PickerSample
//
//  Created by sugurusasaki on 2019/02/15.
//  Copyright © 2019 sugurusasaki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UITextField: ExtensionCompatible {}

extension Extension where Base == UITextField {
    
    // Tapした時にストリームを流します。
    var tap: Observable<UITapGestureRecognizer> {
        let gesture = UITapGestureRecognizer()
        base.addGestureRecognizer(gesture)
        return gesture.rx.event.asObservable()
    }
}
