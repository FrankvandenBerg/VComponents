//
//  VBaseList.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 1/10/21.
//

import SwiftUI

// MARK:- V Base List
/// Core component that is used throughout the framework as a structure that either hosts content, or computes views on demad from an underlying collection of identified data
///
/// Model, and layout can be passed as parameters
///
/// There are three posible layouts:
/// 1. Fixed. Passed as parameter. Component stretches vertically to take required space. Scrolling may be enabled on page.
/// 2. Flexible. Passed as parameter. Component stretches vertically to occupy maximum space, but is constrainted in space given by container. Scrolling may be enabled inside component.
/// 3. Constrained. `.frame()` modifier can be applied to view. Content would be limitd in vertical space. Scrolling may be enabled inside component.
///
/// # Usage Example #
///
/// ```
/// struct ListRow: Identifiable {
///     let id: UUID = .init()
///     let title: String
/// }
///
/// @State var data: [ListRow] = [
///     .init(title: "Red"),
///     .init(title: "Green"),
///     .init(title: "Blue")
/// ]
///
/// var body: some View {
///     ZStack(alignment: .top, content: {
///         ColorBook.canvas.edgesIgnoringSafeArea(.all)
///
///         VBaseList(data: data, content: { row in
///             Text(row.title)
///                 .frame(maxWidth: .infinity, alignment: .leading)
///         })
///             .padding()
///     })
/// }
/// ```
///
public struct VBaseList<Data, ID, Content>: View
    where
        Data: RandomAccessCollection,
        ID: Hashable,
        Content: View
{
    // MARK: Properties
    private let model: VBaseListModel
    
    private let layoutType: VBaseListLayoutType
    
    private let data: [Element]
    private let content: (Data.Element) -> Content
    
    typealias Element = VBaseListElement<ID, Data.Element>
    
    // MARK: Initializers
    public init(
        model: VBaseListModel = .init(),
        layout layoutType: VBaseListLayoutType = .fixed,
        data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.model = model
        self.layoutType = layoutType
        self.data = data.map { .init(id: $0[keyPath: id], value: $0) }
        self.content = content
    }
    
    public init(
        model: VBaseListModel = .init(),
        layout layoutType: VBaseListLayoutType = .fixed,
        data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    )
        where
            Data.Element: Identifiable,
            ID == Data.Element.ID
    {
        self.model = model
        self.layoutType = layoutType
        self.data = data.map { .init(id: $0[keyPath: \Data.Element.id], value: $0) }
        self.content = content
    }
}

// MARK:- Body
extension VBaseList {
    @ViewBuilder public var body: some View {
        switch layoutType {
        case .fixed:
            VStack(spacing: 0, content: {
                ForEach(
                    data.enumeratedArray(),
                    id: \.element.id,
                    content: { contentView(i: $0, element: $1) }
                )
            })
            
        case .flexible:
            VLazyList(
                model: .vertical(model.lazyListModel),
                data: data.enumeratedArray(),
                id: \.element.id,
                rowContent: { contentView(i: $0, element: $1) }
            )
        }
    }
    
    private func contentView(i: Int, element: Element) -> some View {
        VStack(spacing: 0, content: {
            content(element.value)

            if showDivider(for: i) {
                Rectangle()
                    .frame(height: model.layout.dividerHeight)
                    .padding(.vertical, model.layout.dividerMarginVer)
                    .foregroundColor(model.colors.divider)
            }
        })
            .padding(.trailing, model.layout.marginTrailing)
    }
}

// MARK:- Helpers
private extension VBaseList {
    func showDivider(for i: Int) -> Bool {
        model.layout.hasDivider &&
        i <= data.count-2
    }
}

// MARK:- Preview
struct VBaseList_Previews: PreviewProvider {
    struct Row: Identifiable {
        let id: Int
        let color: Color
        let title: String

        static let count: Int = 10
    }
    
    static let rows: [Row] = (0..<Row.count).map { i in
        .init(
            id: i,
            color: [.red, .green, .blue][i % 3],
            title: spellOut(i + 1)
        )
    }
    
    private static func spellOut(_ i: Int) -> String {
        let formatter: NumberFormatter = .init()
        formatter.numberStyle = .spellOut
        return formatter.string(from: .init(value: i))?.capitalized ?? ""
    }
    
    static func rowContent(title: String, color: Color) -> some View {
        HStack(spacing: 10, content: {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(color.opacity(0.8))
                .frame(dimension: 32)

            Text(title)
                .font(.body)
                .foregroundColor(ColorBook.primary)
        })
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    static var previews: some View {
        VBaseList(layout: .fixed, data: rows, id: \.id, content: { row in
            rowContent(title: row.title, color: row.color)
        })
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(20)
    }
}
