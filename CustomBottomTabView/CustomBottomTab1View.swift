//
//  MyTabView.swift
//  SwiftUITutorial
//
//  Created by Rajan Karki on 23/11/2024.
//

import SwiftUI

struct CustomBottomTab1View: View {
    
    enum TabItems: Int, CaseIterable {
        case home = 0
        case favorite = 1
        case chat = 2
        case settings = 3
        
        var title: String {
            switch self {
            case .home:
                return "Home"
            case .favorite:
                return "Favourite"
            case .chat:
                return "Chat"
            case .settings:
                return "Settings"
            }
        }
        
        var imageName: String {
            switch self {
            case .home:
                return "house.fill"
            case .favorite:
                return "heart.fill"
            case .chat:
                return "message.fill"
            case .settings:
                return "gearshape.fill"
            }
        }
    }
    
    @State var selectedTab = TabItems.home.rawValue
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                Text("Home")
                    .tag(0)
                
                Text("Favorite")
                    .tag(1)
                
                Text("Chat")
                    .tag(2)
                
                Text("Settings")
                    .tag(3)
            }
            
            MyCustomTabView()
        
        }
    }
    
    
}

extension CustomBottomTab1View {
    func MyTabViewItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? .green.opacity(0.6) : .clear)
        .cornerRadius(30)
    }
    
    func MyCustomTabView() -> some View {
        ZStack {
            HStack {
                ForEach(TabItems.allCases, id: \.self) {item in
                    Button {
                        selectedTab = item.rawValue
                    } label: {
                        MyTabViewItem(imageName: item.imageName, title: item.title, isActive: item.rawValue == selectedTab)
                    }

                }
                
            }
            .padding(6)
        }
        .frame(height: 70)
        .background(.green.opacity(0.2))
        .cornerRadius(35)
        .padding(.horizontal, 24)
    }
}

#Preview {
    CustomBottomTab1View()
}
