//
//  VProgressBar.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 1/12/21.
//

import SwiftUI

// MARK:- V Progress Bar
/// Indicator component that indicates progress towards completion of a task
public struct VProgressBar: View {
    // MARK: Properties
    private let model: VProgressBarModel
    
    private let range: ClosedRange<Double>
    private let value: Double
    
    /// Initializes componetn with value
    /// 
    /// - Parameters:
    ///   - model: Model that describes UI
    ///   - total: The full amount representing the complete scope of the task
    ///   - value: The completed amount of the task to this point
    public init<V>(
        model: VProgressBarModel = .init(),
        total: V = 1,
        value: V
    )
        where
            V: BinaryFloatingPoint
    {
        self.model = model
        self.range = 0...Double(total)
        self.value = {
            let value: Double = .init(value)
            let min: Double = 0
            let max: Double = .init(total)
            
            return value.fixedInRange(min: min, max: max, step: nil)
        }()
    }
}

// MARK:- Body
extension VProgressBar {
    public var body: some View {
        VSlider(
            model: model.sliderModel,
            range: range,
            step: nil,
            state: .enabled,
            value: .constant(value),
            onChange: nil
        )
    }
}

// MARK:- Preview
struct VProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VProgressBar(value: 0.5)
            .padding()
    }
}