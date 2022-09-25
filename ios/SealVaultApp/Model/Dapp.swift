// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Foundation
import SwiftUI

struct Dapp: Identifiable, Hashable {
    /// Database identifier
    var id: String
    /// Human readable identifier that is either the origin or the registrable domain
    var humanIdentifier: String
    var url: URL?
    var addresses: [Address]
    var lastUsed: String?

    /// Favicon
    var favicon: UIImage

    var addressesByChain: [String: [Address]] {
        var result: [String: [Address]] = Dictionary()
        for address in addresses {
            result[address.chainDisplayName, default: []].append(address)
        }
        return result
    }

    static func fromCore(_ dapp: CoreDapp) -> Self {
        let url = URL(string: dapp.url)
        let addresses = dapp.addresses.map(Address.fromCore)
        return self.init(
            id: dapp.id,
            humanIdentifier: dapp.humanIdentifier,
            url: url,
            addresses: addresses,
            lastUsed: dapp.lastUsed,
            favicon: Self.faviconWithFallback(rawIcon: dapp.favicon)
        )
    }

    static func faviconWithFallback(rawIcon: [UInt8]?) -> UIImage {
        var favicon: UIImage?
        if let icon = rawIcon {
            favicon = UIImage(data: Data(icon))
        }
        let faviconOrFallback = favicon ?? UIImage(systemName: "app")!
        return faviconOrFallback
    }
}

// MARK: - display

extension Dapp {
    var displayName: String {
        humanIdentifier
    }

    var image: Image {
        Image(uiImage: favicon)
    }
}

// MARK: - Search

extension Dapp {
    func matches(_ searchString: String) -> Bool {
        return displayName.localizedCaseInsensitiveContains(searchString)
    }
}

// MARK: - preview

#if DEBUG
    extension Dapp {
        static func uniswap() -> Self {
            let id = "uniswap.org"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "uniswap")!
            let addresses = [Address.ethereumDapp(), Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-01", favicon: favicon
            )
        }

        static func sushi() -> Self {
            let id = "sushi.com"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "sushi")!
            let addresses = [Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-02", favicon: favicon
            )
        }

        static func opensea() -> Self {
            let id = "opensea.io"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "opensea")!
            let addresses = [Address.ethereumDapp(), Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-03", favicon: favicon
            )
        }

        static func ens() -> Self {
            let id = "ens.domains"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "ens")!
            let addresses = [Address.ethereumDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-04", favicon: favicon
            )
        }

        static func aave() -> Self {
            let id = "aave.com"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "aave")!
            let addresses = [Address.ethereumDapp(), Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-05", favicon: favicon
            )
        }

        static func dnd() -> Self {
            let id = "wizards.com"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "dnd")!
            let addresses = [Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-06", favicon: favicon
            )
        }

        static func darkForest() -> Self {
            let id = "zkga.me"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "darkforest")!
            let addresses = [Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-07", favicon: favicon
            )
        }

        static func dhedge() -> Self {
            let id = "dhedge.org"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "dhedge")!
            let addresses = [Address.ethereumDapp(), Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-08", favicon: favicon
            )
        }

        static func oneInch() -> Self {
            let id = "1inch.io"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "1inch")!
            let addresses = [Address.ethereumDapp(), Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-09", favicon: favicon
            )
        }

        static func quickswap() -> Self {
            let id = "quickswap.exchange"
            let url = URL(string: "https://\(id)")
            let favicon = UIImage(named: "quickswap")!
            let addresses = [Address.polygonDapp()]
            return Self(
                id: id, humanIdentifier: id, url: url, addresses: addresses, lastUsed: "2022-08-10", favicon: favicon
            )
        }

    }
#endif