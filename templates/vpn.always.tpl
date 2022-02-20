{{/*
VPN configuration to enable VPN always
All communication will go through VPN on iOS when selected.
VPN will always reconnect on this mode.
*/}}
{{- define "vpn.always" -}}
{{- $dns_name := (index .root.Values "ipsec-vpn-server" "vpn" "dns_name") -}}
<dict>
  <key>UserDefinedName</key>
  <string>{{ $dns_name }} Always</string>

  <key>PayloadDisplayName</key>
  <string>{{ $dns_name }} Always</string>

  <key>PayloadIdentifier</key>
  <string>{{ $dns_name }}.{{ .user.username }}.always</string>

  <key>PayloadUUID</key>
  <string>{{ sha1sum (printf "%s-%s-vpn-always" $dns_name .user.username) | upper }}</string>

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
      <key>Action</key>
      <string>Connect</string>
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
