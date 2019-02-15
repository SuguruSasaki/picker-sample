//
//  Date+extension.swift
//  PickerSample
//
//  Created by sugurusasaki on 2019/02/15.
//  Copyright © 2019 sugurusasaki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Date: ExtensionCompatible {}

extension Extension where Base == Date {
    
    var toStrMonthDay: String {
        let df = DateFormatter()
        df.dateFormat = "MM/dd（EEE）"
        return df.string(from: base)
    }
    
    var toStrTime: String {
        let df = DateFormatter()
        df.dateFormat = "hh:mm:ss"
        return df.string(from: base)
    }
}

