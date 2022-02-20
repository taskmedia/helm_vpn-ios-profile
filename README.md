[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/vpn-ios-profile)](https://artifacthub.io/packages/search?repo=vpn-ios-profile)

# Helm chart: IPsec VPN server with iOS profile

Kubernetes [Helm](https://helm.sh) chart to run a [IPsec VPN server](https://github.com/taskmedia/helm_ipsec-vpn-server) with provided iOS profile to directly connect your Apple device to use the VPN.

The main goal is to simplify the usage of a VPN with iOS by creating a `.mobileconfig` file to be used to add a profile to your iPhone / iPad.

The VPN will have three options how the connection should be managed:

**1. Always**<br />
The VPN is always connected.
The connection will be keep alive until you select another VPN mode (e.g. manual).
When adding a VPN without a profile you do not have the option to automatically reconnect to the VPN.

**2. WiFi**<br />
When connected to your WiFi (WLAN) you will not be connected to the VPN because it will be seen as trusted network.
You can specify a list of SSID (Networkname) which should be trusted.
(Warning: If network you connect shares the same SSID no VPN will be used even if it is not your own trusted network.)

**3. Manual**<br />
If you do not want the VPN to be used automatically select this option.
This allows you to enable it whenever you need it.
You can enable the VPN connection in your iOS preferences.
