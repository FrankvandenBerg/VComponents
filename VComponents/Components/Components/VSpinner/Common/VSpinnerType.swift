//
//  VSpinnerType.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import Foundation

// MARK:- V Spinner Type
public enum VSpinnerType {
    case continous(_ model: VSpinnerModelContinous = .init())
    case dashed(_ model: VSpinnerModelDashed = .init())
    
    public static let `default`: VSpinnerType = .continous()
}
