//
//  VToggleLeftFlexibleContentModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 12/21/20.
//

import SwiftUI

// MARK:- V Toggle Model Setting
public struct VToggleModelSetting {
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
extension VToggleModelSetting {
    public struct Behavior {
        public let contentIsClickable: Bool
        public let spaceIsClickable: Bool
        public let animation: Animation
        
        public init(
            contentIsClickable: Bool = true,
            spaceIsClickable: Bool = false,
            animation: Animation = Animation.easeIn(duration: 0.1)
        ) {
            self.contentIsClickable = contentIsClickable
            self.spaceIsClickable = spaceIsClickable
            self.animation = animation
        }
    }
}

// MARK:- Layout
extension VToggleModelSetting {
    public struct Layout {
        public let size: CGSize
        public let thumbDimension: CGFloat
        let animationOffset: CGFloat
        
        public init(
            size: CGSize = .init(width: 51, height: 31),
            thumbDimension: CGFloat = 27
        ) {
            self.size = size
            self.thumbDimension = thumbDimension
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
extension VToggleModelSetting {
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

extension VToggleModelSetting {
    public struct FillColors {
        public let enabledOn: Color
        public let enabledOff: Color
        public let disabledOn: Color
        public let disabledOff: Color
        
        public init(
            enabledOn: Color = .clear,//ColorBook.ToggleSetting.Fill.enabledOn,
            enabledOff: Color = .clear,//ColorBook.ToggleSetting.Fill.enabledOff,
            disabledOn: Color = .clear,//ColorBook.ToggleSetting.Fill.disabledOn,
            disabledOff: Color = .clear//ColorBook.ToggleSetting.Fill.disabledOff
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
            enabledOn: Color = .clear,//ColorBook.ToggleSetting.Thumb.enabledOn,
            enabledOff: Color = .clear,//ColorBook.ToggleSetting.Thumb.enabledOff,
            disabledOn: Color = .clear,//ColorBook.ToggleSetting.Thumb.disabledOn,
            disabledOff: Color = .clear//ColorBook.ToggleSetting.Thumb.disabledOff
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
extension VToggleModelSetting.Colors {
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
