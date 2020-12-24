//
//  VToggleRightContentModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 12/21/20.
//

import SwiftUI

// MARK:- V Toggle Standard Model
public struct VToggleStandardModel {
    public let behavior: Behavior
    public let layout: Layout
    public let colors: Colors
    
    public init(
        behavior: Behavior = .init(),
        layout: Layout = .init(),
        colors: Colors = .init()
    ) {
        self.behavior = behavior
        self.layout = layout
        self.colors = colors
    }
}

// MARK:- Behavior
extension VToggleStandardModel {
    public struct Behavior {
        public let contentIsClickable: Bool
        public let animation: Animation
        
        public init(
            contentIsClickable: Bool = true,
            animation: Animation = Animation.easeIn(duration: 0.1)
        ) {
            self.contentIsClickable = contentIsClickable
            self.animation = animation
        }
    }
}

// MARK:- Layout
extension VToggleStandardModel {
    public struct Layout {
        public let size: CGSize
        public let thumbDimension: CGFloat
        public let contentSpacing: CGFloat
        let animationOffset: CGFloat
        
        public init(
            size: CGSize = .init(width: 51, height: 31),
            thumbDimension: CGFloat = 27,
            contentSpacing: CGFloat = 10
        ) {
            self.size = size
            self.thumbDimension = thumbDimension
            self.contentSpacing = contentSpacing
            self.animationOffset = {
                let spacing: CGFloat = (size.height - thumbDimension)/2
                let thumnStartPoint: CGFloat = (size.width - thumbDimension)/2
                let offset: CGFloat = thumnStartPoint - spacing
                return offset
            }()
        }
    }
}

// MARK:- Colors
extension VToggleStandardModel {
    public struct Colors {
        public let fill: FillColors
        public let thumb: ThumbColors
        public let content: ContentColors
        
        public init(
            fill: FillColors = .init(),
            thumb: ThumbColors = .init(),
            content: ContentColors = .init()
        ) {
            self.fill = fill
            self.thumb = thumb
            self.content = content
        }
    }
}

extension VToggleStandardModel {
    public struct FillColors {
        public let enabledOn: Color
        public let enabledOff: Color
        public let disabledOn: Color
        public let disabledOff: Color
        
        public init(
            enabledOn: Color = ColorBook.Toggle.Fill.enabledOn,
            enabledOff: Color = ColorBook.Toggle.Fill.enabledOff,
            disabledOn: Color = ColorBook.Toggle.Fill.disabledOn,
            disabledOff: Color = ColorBook.Toggle.Fill.disabledOff
        ) {
            self.enabledOn = enabledOn
            self.enabledOff = enabledOff
            self.disabledOn = disabledOn
            self.disabledOff = disabledOff
        }
    }
    
    public struct ThumbColors {
        public let enabledOn: Color
        public let enabledOff: Color
        public let disabledOn: Color
        public let disabledOff: Color
        
        public init(
            enabledOn: Color = ColorBook.Toggle.Thumb.enabledOn,
            enabledOff: Color = ColorBook.Toggle.Thumb.enabledOff,
            disabledOn: Color = ColorBook.Toggle.Thumb.disabledOn,
            disabledOff: Color = ColorBook.Toggle.Thumb.disabledOff
        ) {
            self.enabledOn = enabledOn
            self.enabledOff = enabledOff
            self.disabledOn = disabledOn
            self.disabledOff = disabledOff
        }
    }
    
    public struct ContentColors {
        public let pressedOpacity: Double
        public let disabledOpacity: Double
        
        public init(
            pressedOpacity: Double = 0.5,
            disabledOpacity: Double = 0.5
        ) {
            self.pressedOpacity = pressedOpacity
            self.disabledOpacity = disabledOpacity
        }
    }
}

// MARK:- Mapping
extension VToggleStandardModel.Colors {
    func foregroundOpacity(state: VToggleInternalState) -> Double {
        switch state {
        case .enabled: return 1
        case .pressed: return content.pressedOpacity
        case .disabled: return content.disabledOpacity
        }
    }
    
    func fillColor(isOn: Bool, state: VToggleInternalState) -> Color {
        switch (isOn, state) {
        case (true, .enabled): return fill.enabledOn
        case (false, .enabled): return fill.enabledOff
        case (true, .pressed): return fill.enabledOn
        case (false, .pressed): return fill.enabledOff
        case (true, .disabled): return fill.disabledOn
        case (false, .disabled): return fill.disabledOff
        }
    }
    
    func thumbColor(isOn: Bool, state: VToggleInternalState) -> Color {
        switch (isOn, state) {
        case (true, .enabled): return thumb.enabledOn
        case (false, .enabled): return thumb.enabledOff
        case (true, .pressed): return thumb.enabledOn
        case (false, .pressed): return thumb.enabledOff
        case (true, .disabled): return thumb.disabledOn
        case (false, .disabled): return thumb.disabledOff
        }
    }
}