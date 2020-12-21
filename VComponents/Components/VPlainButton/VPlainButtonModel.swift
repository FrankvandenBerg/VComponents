//
//  VPlainButtonModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI

// MARK:- V Plain Button Model
public struct VPlainButtonModel {
    public let layout: Layout
    public let colors: Colors
    public let fonts: Fonts
    
    public init(
        layout: Layout = .init(),
        colors: Colors = .init(),
        fonts: Fonts = .init()
    ) {
        self.layout = layout
        self.colors = colors
        self.fonts = fonts
    }
}

// MARK:- Layout
extension VPlainButtonModel {
    public struct Layout {
        public let hitAreaOffsetHor: CGFloat
        public let hitAreaOffsetVer: CGFloat
        
        public init(
            hitAreaOffsetHor: CGFloat = 15,
            hitAreaOffsetVer: CGFloat = 5
        ) {
            self.hitAreaOffsetHor = hitAreaOffsetHor
            self.hitAreaOffsetVer = hitAreaOffsetVer
        }
    }
}

// MARK:- Colors
extension VPlainButtonModel {
    public struct Colors {
        public let foreground: ForegroundColors
        
        public init(
            foreground: ForegroundColors = .init()
        ) {
            self.foreground = foreground
        }
    }
}

extension VPlainButtonModel.Colors {
    public struct ForegroundColors {
        public let enabled: Color
        public let pressed: Color
        public let disabled: Color
        public let pressedOpacity: Double
        public let disabledOpacity: Double
        
        public init(
            enabled: Color = ColorBook.PlainButton.Text.enabled,
            pressed: Color = ColorBook.PlainButton.Text.pressed,
            disabled: Color = ColorBook.PlainButton.Text.disabled,
            pressedOpacity: Double = 0.5,
            disabledOpacity: Double = 0.5
        ) {
            self.enabled = enabled
            self.pressed = pressed
            self.disabled = disabled
            self.pressedOpacity = pressedOpacity
            self.disabledOpacity = disabledOpacity
        }
    }
}

// MARK:- Fonts
extension VPlainButtonModel {
    public struct Fonts {
        public let title: Font
        
        public init(
            title: Font = FontBook.buttonLarge
        ) {
            self.title = title
        }
    }
}

// MARK:- Mapping
extension VPlainButtonModel.Colors {
    func foregroundColor(state: VPlainButtonInternalState) -> Color {
        switch state {
        case .enabled: return foreground.enabled
        case .pressed: return foreground.pressed
        case .disabled: return foreground.disabled
        }
    }
    
    func foregroundOpacity(state: VPlainButtonInternalState) -> Double {
        switch state {
        case .enabled: return 1
        case .pressed: return foreground.pressedOpacity
        case .disabled: return foreground.disabledOpacity
        }
    }
}
