//
//  AdvancedTabView.swift
//  SwiftUITutorial
//
//  Created by Rajan Karki on 23/11/2024.
//

import SwiftUI

enum Tab: String, Hashable, CaseIterable {
    case home = "house"
    case notification = "bell"
    case new = "plus.circle"
    case explore = "globe.europe.africa"
    case profile = "person"
    
    var color: Color {
        switch self {
        case .home: return .green
        case .notification: return .mint
        case .new: return .indigo
        case .explore: return .purple
        case .profile: return .purple
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .notification: return "Notification"
        case .new: return "New"
        case .explore: return "Explore"
        case .profile: return "Profile"
        }
    }
}

struct CustomBottomTab2View: View {
    
    @State private var selectedTab = Tab.new
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    
                    ForEach(Tab.allCases, id: \.self) {item in
                        Text("\(item.title)".uppercased())
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(item.color.opacity(0.3))
                            .tag(item)
                    }
                }
                CustomBottomTabBarView(currentTab: $selectedTab)
            }
        }
    }
}
private let buttonDimen: CGFloat = 55

struct CustomBottomTabBarView: View {
    @Binding var currentTab: Tab
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tabItem in
                CustomTabItem(tabImage: tabItem.rawValue)
                    .frame(width: buttonDimen, height: buttonDimen)
                    .onTapGesture {
                        currentTab = tabItem
                    }
            }
        }
        .frame(width: (buttonDimen * CGFloat(Tab.allCases.count))+60)
        .tint(.black)
        .padding(.vertical, 2.5)
        .background(.white)
        .clipShape(Capsule(style: .continuous))
        .overlay {
            SelectedTabOverlay(currentTab: $currentTab)
        }
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 10)
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.3), value: currentTab)
    }
}


private struct CustomTabItem: View {
    let tabImage: String
    var body: some View {
        Image(systemName: tabImage)
            .renderingMode(.template)
            .tint(.black)
            .fontWeight(.bold)
            .frame(width: buttonDimen, height: buttonDimen)
    }
}

struct SelectedTabOverlay: View {
    
    @Binding var currentTab: Tab
    
    private var horizontalOffset: CGFloat {
        switch currentTab {
        case .home:
            return -138
        case .notification:
            return -72
        case .new:
            return 0
        case .explore:
            return 72
        case .profile:
            return 138
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(currentTab.color)
                .frame(width: buttonDimen-12, height: buttonDimen-12)
                .cornerRadius(12)
                .rotationEffect(Angle(degrees: 45))
                
            CustomTabItem(tabImage: "\(currentTab.rawValue).fill")
                .foregroundColor(.white)
        }
        .offset(x: horizontalOffset)
    }
}

#Preview {
    CustomBottomTab2View()
}


#Preview("CustomBottomTabView") {
    CustomBottomTabBarView(currentTab: .constant(Tab.explore))
}
