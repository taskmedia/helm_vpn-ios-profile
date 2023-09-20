[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/taskmedia)](https://artifacthub.io/packages/helm/taskmedia/vpn-ios-profile)

# Helm chart: IPsec VPN server with iOS profile

Kubernetes [Helm](https://helm.sh) chart to run a [IPsec VPN server](https://github.com/taskmedia/helm_ipsec-vpn-server) with provided iOS profile to directly connect your Apple device to use the VPN.

The main goal is to simplify the usage of a VPN with iOS by creating a `.mobileconfig` file to be used to add a profile to your iPhone / iPad.

The VPN will have three options how the connection should be managed:

**1. Always**<br />
The VPN is always connected.
The connection will be keep alive until you select another VPN mode (e.g. manual).
When adding a VPN without a profile you do not have the option to automatically reconnect to the VPN.

**2. Manual**<br />
If you do not want the VPN to be used automatically select this option.
This allows you to enable it whenever you need it.
You can enable the VPN connection in your iOS preferences.

**3. WiFi**<br />
When connected to your WiFi (WLAN) you will not be connected to the VPN because it will be seen as trusted network.
You can specify a list of SSID (Networkname) which should be trusted.
(Warning: If network you connect shares the same SSID no VPN will be used even if it is not your own trusted network.)

## Installation

To deploy the Helm chart first copy the [`values.yaml`](./values.yaml)-file and customize your deployment.
After it was modified you can deploy the chart with the following command.

```bash
$ helm repo add taskmedia https://helm.task.media
$ helm repo update

$ helm show values taskmedia/vpn-ios-profile > ./my-values.yaml
$ vi ./my-values.yaml

$ helm upgrade --install vpn taskmedia/vpn-ios-profile --values ./my-values.yaml
```

You can also use OCI Helm charts from [ghcr.io](https://ghcr.io/):

```bash
$ helm upgrade --install vpn oci://ghcr.io/taskmedia/vpn-ios-profile
```
