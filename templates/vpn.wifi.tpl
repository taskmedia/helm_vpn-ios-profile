{{/*
VPN configuration to enable VPN always when not connected to known network
All communication will go through VPN on iOS when selected and not in list of known networks.
VPN will always reconnect on this mode.
*/}}
{{- define "vpn.wifi" -}}
{{- $dns_name := (index .root.Values "ipsec-vpn-server" "vpn" "dns_name") -}}
<dict>
  <key>UserDefinedName</key>
  <string>{{ $dns_name }} Wi-Fi</string>

  <key>PayloadDisplayName</key>
  <string>{{ $dns_name }} Wi-Fi</string>

  <key>PayloadIdentifier</key>
  <string>{{ $dns_name }}.{{ .user.username }}.wifi</string>

  <key>PayloadUUID</key>
  <string>{{ sha1sum (printf "%s-%s-vpn-wifi" $dns_name .user.username) | upper }}</string>

  <key>VPNType</key>
  <string>IPSec</string>

  <key>IPSec</key>
  <dict>
    <key>RemoteAddress</key>
    <string>{{ $dns_name }}</string>

    <key>AuthenticationMethod</key>
    <string>SharedSecret</string>

    <key>XAuthName</key>
    <string>{{ .user.username }}</string>

    <key>XAuthPassword</key>
    <string>{{ .user.password }}</string>

    <key>XAuthEnabled</key>
    <integer>1</integer>

    <key>LocalIdentifierType</key>
    <string>KeyID</string>

    <key>SharedSecret</key>
    <data>
    {{ (index .root.Values "ipsec-vpn-server" "vpn" "psk") | b64enc }}
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
        {{- range .root.Values.trusted_ssids }}
        <string>{{- . -}}</string>
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
