//
//  ViewReactor.swift
//  PickerSample
//
//  Created by sugurusasaki on 2019/02/15.
//  Copyright © 2019 sugurusasaki. All rights reserved.
//

import ReactorKit
import RxSwift

final class ViewReactor: Reactor {
    
    enum InputType {
        case A
        case B
        case C
        case none
    }
    
    enum Action {
        case tap(InputType)
        case changeDateA(Date)
        case tapPickerClose
    }
    
    enum Mutation {
        case togglePicker(Bool, InputType)
        case updateStr(String, InputType)
    }
    
    struct State {
        var str_A: String
        var str_B: String
        var str_C: String
        var currentType: InputType
        var isTimePicker: Bool
        var isPicker: Bool
    }
    
    var initialState: ViewReactor.State
    
    init() {
        self.initialState = State(
            str_A: "",
            str_B: "",
            str_C: "",
            currentType: .none,
            isTimePicker: false,
            isPicker: false
        )
    }
}

extension ViewReactor {
    
    func mutate(action: ViewReactor.Action) -> Observable<ViewReactor.Mutation> {
        switch action {
        case .tap(let type):
            return Observable.just(Mutation.togglePicker(true, type))
            
        case .tapPickerClose:
            return Observable.just(Mutation.togglePicker(false, InputType.none))
            
        case .changeDateA(let date):
            let str = self.currentState.currentType == InputType.C ? date.ex.toStrTime : date.ex.toStrMonthDay
            return Observable.just(Mutation.updateStr(str, self.currentState.currentType))
        }
    }
    
    func reduce(state: ViewReactor.State, mutation: ViewReactor.Mutation) -> ViewReactor.State {
        var newState = state
        switch mutation {
            
        case .togglePicker(let bool, let type) where type == InputType.C:
            newState.isPicker = bool
            newState.isTimePicker = true
            newState.currentType = type
            
        case .togglePicker(let bool, let type):
            newState.isPicker = bool
            newState.isTimePicker = false
            newState.currentType = type
            break
        
        case .updateStr(let str, let type) where type == InputType.A:
            newState.str_A = str;
            break
            
        case .updateStr(let str, let type) where type == InputType.B:
            newState.str_B = str
            break
            
        case .updateStr(let str, let type) where type == InputType.C:
            newState.str_C = str
            break
            
        default:
            break;
        }
        return newState
    }
}
