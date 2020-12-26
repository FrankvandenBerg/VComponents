//
//  VTabNavigationViewDemoView.swift
//  VComponentsDemo
//
//  Created by Vakhtang Kontridze on 12/26/20.
//

import SwiftUI
import VComponents

// MARK:- V Tab Navigation View Demo View
struct VTabNavigationViewDemoView: View {
    // MARK: Properties
    static let navigationBarTitle: String = "Tab Navigation View"
}

// MARK:- Body
extension VTabNavigationViewDemoView {
    var body: some View {
        VBaseView(title: Self.navigationBarTitle, content: {
            VStack(spacing: 20, content: {
                Text("Tan Navigation View should only ever be used on a root view. Continue?")
                    .multilineTextAlignment(.center)
                
                VSecondaryButton(
                    action: { SceneDelegate.setRootView(to: VTabNavigationViewDemoViewWalkthroughView()) },
                    title: "Start Demo"
                )
            })
                .padding(20)
        })
    }
}

// MARK:- V Tab Navigation View Walkthrough View
private struct VTabNavigationViewDemoViewWalkthroughView: View {
    static let navigationBarTitle: String = ""
    @State private var selection: Int = 0
}

private extension VTabNavigationViewDemoViewWalkthroughView {
    var body: some View {
        VTabNavigationView(
            selection: $selection,
            pageOne: VTabNavigationViewPage(item: tabItem(iconName: "Artists", title: "Artists"), content: pageOne),
            pageTwo: VTabNavigationViewPage(item: tabItem(iconName: "Albums", title: "Albums"), content: pageTwo),
            pageThree: VTabNavigationViewPage(item: tabItem(iconName: "Songs", title: "Songs"), content: pageThree),
            pageFour: VTabNavigationViewPage(item: tabItem(iconName: "Favorites.On", title: "Favorites"), content: pageFour)
        )
    }

    private var pageOne: some View {
        VNavigationView(content: {
            VBaseView(title: "Red Page", content: {
                ZStack(content: {
                    Color.red
                    
                    NavigationLink(
                        destination: VBaseView(title: "Details", content: { Color.orange }),
                        label: { VSecondaryButton(action: {}, title: "Go to Details").allowsHitTesting(false) }
                    )
                })
            })
        })
    }

    private var pageTwo: some View {
        VBaseView(title: "Green Page", content: {
            Color.green
        })
    }

    private var pageThree: some View {
        VBaseView(title: "Blue Page", content: {
            Color.blue
        })
    }

    private var pageFour: some View {
        VBaseView(title: "Yellow Page", content: {
            Color.yellow
        })
    }

    private func tabItem(iconName: String, title: String) -> some View {
        VStack(content: {
            Image(iconName).renderingMode(.template)
            Text(title)
        })
    }
}

// MARK:- Preview
struct VTabNavigationViewDemoView_Previews: PreviewProvider {
    static var previews: some View {
        VTabNavigationViewDemoView()
    }
}