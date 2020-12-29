//
//  ColorBook.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI

// MARK:- Color Book
public struct ColorBook {
    private init() {}
}

// MARK:- General
extension ColorBook {
    public static let canvas: Color = .init(componentAsset: "Canvas")
    public static let layer: Color = .init(componentAsset: "Layer")
    
    public static let primary: Color = .init(componentAsset: "Primary")
    public static let primaryInverted: Color = .init(componentAsset: "PrimaryInverted")
    
    public static let secondary: Color = .init(componentAsset: "Secondary")
    
    public static let accent: Color = .init(componentAsset: "Accent")
}

// MARK:- Square Button
extension ColorBook {
    public struct SquareButtonFilled {
        public struct Foreground {
            public static let enabled: Color = .clear//PrimaryButtonFilled.Foreground.enabled
            public static let pressed: Color = .clear//PrimaryButtonFilled.Foreground.enabled
            public static let disabled: Color = .clear//PrimaryButtonFilled.Foreground.enabled
            
            private init() {}
        }
        
        public struct Background {
            public static let enabled: Color = .clear//PrimaryButtonFilled.Background.enabled
            public static let pressed: Color = .clear//PrimaryButtonFilled.Background.pressed
            public static let disabled: Color = .clear//PrimaryButtonFilled.Background.disabled
            
            private init() {}
        }
        
        private init() {}
    }
    
    public struct SquareButtonBordered {
        public struct Foreground {
            public static let enabled: Color = .clear//PrimaryButtonBordered.Foreground.enabled
            public static let pressed: Color = .clear//PrimaryButtonBordered.Foreground.pressed
            public static let disabled: Color = .clear//PrimaryButtonBordered.Foreground.disabled
            
            private init() {}
        }
        
        public struct Background {
            public static let enabled: Color = .clear//PrimaryButtonBordered.Background.enabled
            public static let pressed: Color = .clear//PrimaryButtonBordered.Background.pressed
            public static let disabled: Color = .clear//PrimaryButtonBordered.Background.disabled
            
            private init() {}
        }
        
        public struct Border {
            public static let enabled: Color = .clear//PrimaryButtonBordered.Border.enabled
            public static let pressed: Color = .clear//PrimaryButtonBordered.Border.pressed
            public static let disabled: Color = .clear//PrimaryButtonBordered.Border.disabled
            
            private init() {}
        }
        
        private init() {}
    }
}

// MARK:- Plain Button
extension ColorBook {
    public struct PlainButtonStandard {
        public struct Foreground {
            public static let enabled: Color = ColorBook.accent
            public static let pressed: Color = enabled      // Opacity is applied
            public static let disabled: Color = enabled     // Opacity is applied
            
            private init() {}
        }
        
        private init() {}
    }
}

// MARK:- Chevron Button
extension ColorBook {
    public struct ChevronButtonFilled {
        public struct Background {
            public static let enabled: Color = .init(componentAsset: "ChevronButtonFilled.Background.enabled")
            public static let pressed: Color = .init(componentAsset: "ChevronButtonFilled.Background.pressed")
            public static let disabled: Color = .init(componentAsset: "ChevronButtonFilled.Background.disabled")
            
            private init() {}
        }
        
        public struct Foreground {
            public static let enabled: Color = ColorBook.primary
            public static let pressed: Color = enabled      // Opacity is applied
            public static let disabled: Color = enabled     // Opacity is applied
            
            private init() {}
        }
        
        private init() {}
    }
    
    public struct ChevronButtonPlain {
        public struct Foreground {
            public static let enabled: Color = .init(componentAsset: "ChevronButtonPlain.Foreground.enabled")
            public static let pressed: Color = enabled      // Opacity is applied
            public static let disabled: Color = enabled     // Opacity is applied
            
            private init() {}
        }
        
        private init() {}
    }
}

// MARK:- Toggle
extension ColorBook {
    public struct Toggle {
        public struct Fill {
            public static let enabledOn: Color = .clear//PrimaryButtonFilled.Background.enabled
            public static let enabledOff: Color = .init(componentAsset: "Toggle.Fill.enabledOff")
            public static let disabledOn: Color = .clear//PrimaryButtonFilled.Background.disabled
            public static let disabledOff: Color = .init(componentAsset: "Toggle.Fill.disabledOff")
            
            private init() {}
        }
        
        public struct Thumb {
            public static let enabledOn: Color = .init(componentAsset: "Toggle.Thumb.enabledOn")
            public static let enabledOff: Color = enabledOn
            public static let disabledOn: Color = enabledOn
            public static let disabledOff: Color = enabledOn
            
            private init() {}
        }
        
        private init() {}
    }
}

// MARK:- Slider
extension ColorBook {
    public struct Slider {
        public struct Track {
            public static let enabled: Color = Toggle.Fill.enabledOff
            public static let disabled: Color = Toggle.Fill.disabledOff
            
            private init() {}
        }
        
        public struct Progress {
            public static let enabled: Color = Toggle.Fill.enabledOn
            public static let disabled: Color = Toggle.Fill.disabledOn
            
            private init() {}
        }
        
        public struct ThumbFill {
            public static let enabled: Color = Toggle.Thumb.enabledOn
            public static let disabled: Color = enabled
            
            private init() {}
        }
        
        public struct ThumbBorder {
            public static let enabled: Color = .init(componentAsset: "Slider.ThumbBorderWidth.enabled")
            public static let disabled: Color = .init(componentAsset: "Slider.ThumbBorderWidth.disabled")
            
            private init() {}
        }
        
        public struct ThumbShadow {
            public static let enabled: Color = .init(componentAsset: "Slider.ThumbShadow.enabled")
            public static let disabled: Color = .init(componentAsset: "Slider.ThumbShadow.disabled")
            
            private init() {}
        }
        
        private init() {}
    }
}

// MARK:- Spinner
extension ColorBook {
    public struct Spinner {
        public static let background: Color = ColorBook.accent
        
        private init() {}
    }
}

// MARK:- Sheet
extension ColorBook {
    public struct Sheet {
        public static let background: Color = ColorBook.layer
        
        private init() {}
    }
    
    public struct SheetCustom {
        public static let background: Color = Sheet.background
        
        private init() {}
    }
}

// MARK:- Tab Navigation View
extension ColorBook {
    public struct TabNavigationViewStandard {
        public static let background: Color = ColorBook.canvas
        public static let item: Color = ColorBook.secondary
        public static let itemSelected: Color = ColorBook.accent
        
        private init() {}
    }
}

// MARK:- Navigation View
extension ColorBook {
    public struct NavigationView {
        public static let background: Color = ColorBook.canvas
        
        private init() {}
    }
}

// MARK:- Side Bar
extension ColorBook {
    public struct SideBarStandard {
        public static let background: Color = ColorBook.Sheet.background
        public static let blinding: Color = .init(componentAsset: "SideBarStandard.Blinding")
        
        private init() {}
    }
}

// MARK:- Helper
public extension Color {
    init(componentAsset name: String) {
        guard
            let bundle = Bundle(identifier: "com.vakhtang-kontridze.VComponents"),
            let uiColor = UIColor(named: name, in: bundle, compatibleWith: nil)
        else {
            preconditionFailure()
        }
        
        self.init(uiColor)
    }
}
