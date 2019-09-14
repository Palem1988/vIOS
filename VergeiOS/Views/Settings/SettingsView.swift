//
//  SettingsView.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 02/09/2019.
//  Copyright © 2019 Verge Currency. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("Privacy"),
                    footer: Text("Protect your privacy while using the Verge iOS wallet.")
                ) {
                    SettingItemView(label: Text("Tor connection"), icon: Image("Tor"))
                }
                Section(header: Text("Settings")) {
                    SettingItemView(label: Text("Fiat valuta"), icon: Image("Currency"))
                    SettingItemView(label: Text("Verander wallet PIN"), icon: Image("Pin"))
                    SettingItemView(label: Text("Gebruik Touch ID"), icon: Image("TouchID"))
                }
                Section(header: Text("Extra")) {
                    SettingItemView(label: Text("Credits"), icon: Image("Credits"))
                    SettingItemView(label: Text("Rate"), icon: Image("RateApp"))
                    SettingItemView(label: Text("Website"), icon: Image("Website"))
                    SettingItemView(label: Text("Contribute"), icon: Image("GitHub"))
                }
            }
            .background(Color.backgroundGrey())
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Settings").foregroundColor(.secondaryDark()))
        }
    }
}

struct SettingItemView: View {
    let label: Text
    let icon: Image
    
    var body: some View {
        HStack {
            icon
                .foregroundColor(.primaryLight())
            label
                .font(.avenir(size: 16))
                .foregroundColor(.primaryDark())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
