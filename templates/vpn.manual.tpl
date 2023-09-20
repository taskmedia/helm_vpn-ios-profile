{{/*
VPN configuration to enable VPN manual
Connection can be disabled by this setting and enabled for a period of time if necessary.
*/}}
{{- define "vpn.manual" -}}
<dict>
  <key>UserDefinedName</key>
  <string>{{ .vpn.name | default .vpn.address }} manual</string>

  <key>PayloadDisplayName</key>
  <string>{{ .vpn.address }} manual</string>

  <key>PayloadIdentifier</key>
  <string>{{ .vpn.address }}.{{ .vpn.username }}.manual</string>

  <key>PayloadUUID</key>
  <string>{{ sha1sum (printf "%s-%s-vpn-manual" .vpn.address .vpn.username) | upper }}</string>

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

  <key>OverridePrimary</key>
  <true/>

  <key>IPv4</key>
  <dict>
    <key>OverridePrimary</key>
    <integer>1</integer>
  </dict>

</dict>
{{- end }}
