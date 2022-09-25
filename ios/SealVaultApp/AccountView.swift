// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

import SwiftUI

struct AccountView: View {
    var account: Account

    @State private var selectedDapp: Dapp?
    @State private var searchString: String = ""

    var listedDapps: [Dapp] {
        let filteredDapps = searchString.isEmpty ? account.dapps : account.dapps.filter { $0.matches(searchString) }
        return filteredDapps
    }

    var body: some View {
        ScrollViewReader { _ in
            List {
                Section {
                    ForEach(account.wallets) { wallet in
                        NavigationLink {
                            WalletView(account: account, address: wallet)
                        } label: {
                            WalletRow(address: wallet)
                        }
                    }
                } header: {
                    Text("Wallets")
                }
                Section {
                    ForEach(listedDapps) { dapp in
                        NavigationLink(tag: dapp, selection: $selectedDapp) {
                            DappView(account: account, dapp: dapp)
                        } label: {
                            DappRow(dapp: dapp).accessibilityIdentifier(dapp.displayName)
                        }
                    }
                } header: {
                    Text("Dapps")
                }
            }
            .accessibilityRotor("Dapps", entries: account.dapps, entryLabel: \.displayName)
//            .searchable(text: $searchString) {
//                let searchResults = account.getDappSearchSuggestions(searchString: searchString)
//                ForEach(searchResults) { suggestion in
//                    Text(suggestion.displayName).searchCompletion(suggestion.displayName)
//                }
//            }
        }
        .navigationTitle(Text(account.displayName))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                AccountImageCircle(account: account)
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ViewModel.buildForPreview()
        return AccountView(account: model.activeAccount)
    }
}