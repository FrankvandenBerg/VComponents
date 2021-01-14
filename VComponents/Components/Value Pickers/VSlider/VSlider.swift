//
//  VSlider.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI

// MARK:- V Slider
/// Value picker component that selects value from a bounde a bounded linear range of values
public struct VSlider: View {
    // MARK: Properties
    private let model: VSliderModel
    
    private let min, max: Double
    private var range: ClosedRange<Double> { min...max }
    private let step: Double?
    
    @Binding private var value: Double
    private let state: VSliderState
    
    private let action: ((Bool) -> Void)?
    
    // MARK: Initializers
    /// Initializes component with value
    ///
    /// # Usage Example #
    /// Short initialization
    /// ```
    /// @State var value: Double = 0.5
    ///
    /// var body: some View {
    ///     VSlider(value: $value)
    /// }
    /// ```
    ///
    /// Full initialization
    /// ```
    /// let model: VSliderModel = .init()
    /// @State var state: VSliderState = .enabled
    /// @State var value: Double = 0.5
    ///
    /// var body: some View {
    ///     VSlider(
    ///         model: model,
    ///         range: 0...1,
    ///         step: 0.1,
    ///         state: state,
    ///         value: $value,
    ///         onChange: { isDragged in
    ///             switch isDragged {
    ///             case false: print("Drag ended")
    ///             case true: print("Value changed")
    ///             }
    ///         }
    ///     )
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - model: Model that describes UI
    ///   - range: Range of values
    ///   - step: Increment of value over range
    ///   - state: State that describes state, such as enabled or disabled
    ///   - value: Selected value
    ///   - action: Callback for when editing begins and ends
    public init<V>(
        model: VSliderModel = .init(),
        range: ClosedRange<V> = 0...1,
        step: V? = nil,
        state: VSliderState = .enabled,
        value: Binding<V>,
        onChange action: ((Bool) -> Void)? = nil
    )
        where
            V: BinaryFloatingPoint,
            V.Stride: BinaryFloatingPoint
    {
        self.model = model
        self.min = .init(range.lowerBound)
        self.max = .init(range.upperBound)
        self.step = {
            switch step {
            case nil: return nil
            case let step?: return .init(step)
            }
        }()
        self._value = .init(from: value, range: range, step: step)
        self.state = state
        self.action = action
    }
}

// MARK:- Body
extension VSlider {
    public var body: some View {
        GeometryReader(content: { proxy in
            ZStack(alignment: .leading, content: {
                track
                progress(in: proxy)
            })
                .mask(RoundedRectangle(cornerRadius: model.layout.cornerRadius))
            
                .overlay(thumb(in: proxy))
            
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ dragChanged($0, in: proxy) })
                        .onEnded(dragEnded)
                )
                .disabled(state.isDisabled)
        })
            .frame(height: model.layout.height)
    }

    private var track: some View {
        Rectangle()
            .foregroundColor( model.colors.trackColor(state: state))
    }

    private func progress(in proxy: GeometryProxy) -> some View {
        Rectangle()
            .frame(width: progressWidth(in: proxy))

            .foregroundColor(model.colors.progressColor(state: state))
    }
    
    @ViewBuilder private func thumb(in proxy: GeometryProxy) -> some View {
        if model.layout.hasThumb {
            Group(content: {
                ZStack(content: {
                    RoundedRectangle(cornerRadius: model.layout.thumbCornerRadius)
                        .foregroundColor(model.colors.thumbFillColor(state: state))
                        .shadow(color: model.colors.thumbShadow(state: state), radius: model.layout.thumbShadowRadius)
                    
                    RoundedRectangle(cornerRadius: model.layout.thumbCornerRadius)
                        .strokeBorder(model.colors.thumbBorderWidth(state: state), lineWidth: model.layout.thumbBorderWidth)
                })
                    .frame(dimension: model.layout.thumbDimension)
                    .offset(x: thumbOffset(in: proxy))
            })
                .frame(maxWidth: .infinity, alignment: .leading)    // Must be put into group, as content already has frame
                .allowsHitTesting(false)
        }
    }
}

// MARK:- Drag
private extension VSlider {
    func dragChanged(_ draggedValue: DragGesture.Value, in proxy: GeometryProxy) {
        let range: Double = max - min
        let width: Double = .init(proxy.size.width)
        let draggedValue: Double = .init(draggedValue.location.x)

        let rawValue: Double = (draggedValue / width) * range
        
        let valueFixed: Double = rawValue.fixedInRange(min: min, max: max, step: step)
        
        withAnimation(model.animation, { value = valueFixed })
        
        action?(true)
    }
    
    func dragEnded(_ draggedValue: DragGesture.Value) {
        action?(false)
    }
}

// MARK:- Progress
private extension VSlider {
    func progressWidth(in proxy: GeometryProxy) -> CGFloat {
        let range: CGFloat = .init(max - min)
        let width: CGFloat = proxy.size.width
        let value: CGFloat = .init(self.value)

        return (value / range) * width
    }
}

// MARK:- Thumb Offset
private extension VSlider {
    func thumbOffset(in proxy: GeometryProxy) -> CGFloat {
        let progressW: CGFloat = progressWidth(in: proxy)
        let thumbW: CGFloat = model.layout.thumbDimension
        let offset: CGFloat = progressW - thumbW / 2
        
        return offset
    }
}

// MARK:- Preview
struct VSlider_Previews: PreviewProvider {
    @State private static var value: Double = 0.5

    static var previews: some View {
        VSlider(value: $value)
            .padding()
    }
}
