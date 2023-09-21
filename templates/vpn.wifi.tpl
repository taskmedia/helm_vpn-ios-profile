{{/*
VPN configuration to enable VPN always when not connected to known network
All communication will go through VPN on iOS when selected and not in list of known networks.
VPN will always reconnect on this mode.
*/}}
{{- define "vpn.wifi" -}}
<dict>
  <key>UserDefinedName</key>
  <string>{{ .vpn.name | default .vpn.address }} Wi-Fi</string>

  <key>PayloadDisplayName</key>
  <string>{{ .vpn.address }} Wi-Fi</string>

  <key>PayloadIdentifier</key>
  <string>{{ .vpn.address }}.{{ .vpn.username }}.wifi</string>

  <key>PayloadUUID</key>
  <string>{{ sha1sum (printf "%s-%s-vpn-wifi" .vpn.address .vpn.username) | upper }}</string>

  <key>VPNType</key>
  <string>IPSec</string>

  <key>IPSec</key>
  <dict>
    <key>RemoteAddress</key>
    <string>{{ .vpn.address }}</string>

    <key>AuthenticationMethod</key>
    <string>SharedSecret</string>

    <key>XAuthName</key>
    <string>{{ .vpn.username }}</string>

    <key>XAuthPassword</key>
    <string>{{ .vpn.password }}</string>

    <key>XAuthEnabled</key>
    <integer>1</integer>

    {{- if .vpn.group }}
    <key>LocalIdentifier</key>
    <string>{{ .vpn.username }}</string>

    {{- end }}

    <key>LocalIdentifierType</key>
    <string>KeyID</string>

    <key>SharedSecret</key>
    <data>
    {{ .vpn.psk | b64enc }}
    </data>
  </dict>

  <key>PayloadType</key>
  <string>com.apple.vpn.managed</string>

  <key>PayloadVersion</key>
  <integer>1</integer>

  <key>OnDemandEnabled</key>
  <integer>1</integer>

  <key>OnDemandRules</key>
  <array>
    <dict>
      <key>InterfaceTypeMatch</key>
      <string>WiFi</string>

      <key>SSIDMatch</key>
      <array>
        {{- range $.root.Values.wifi }}
        <string>{{- .ssid -}}</string>
        {{- end}}
      </array>

      <key>Action</key>
      <string>Disconnect</string>
    </dict>
    <dict>
      <key>InterfaceTypeMatch</key>
      <string>WiFi</string>

      <key>Action</key>
      <string>Connect</string>
    </dict>
    <dict>
      <!-- VPN Default state -->
      <key>Action</key>
      <string>Disconnect</string>
    </dict>
  </array>

  <key>OverridePrimary</key>
  <true/>

  <key>IPv4</key>
  <dict>
    <key>OverridePrimary</key>
    <integer>1</integer>
  </dict>

</dict>
{{- end }}
