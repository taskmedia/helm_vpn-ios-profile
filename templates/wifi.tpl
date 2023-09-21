{{/*
WiFi connections
*/}}
{{- define "wifi" -}}
<dict>
  <key>AutoJoin</key>
  <true/>
  <key>CaptiveBypass</key>
  <false/>
  <key>DisableAssociationMACRandomization</key>
  <false/>
  <key>EncryptionType</key>
  <string>WPA2</string>
  <key>HIDDEN_NETWORK</key>
  <false/>
  <key>IsHotspot</key>
  <false/>
  <key>Password</key>
  <string>{{ .wifi.password }}</string>
  <key>PayloadDescription</key>
  <string>Configures Wi-Fi settings {{ .wifi.ssid }}</string>
  <key>PayloadDisplayName</key>
  <string>Wi-Fi {{ .wifi.ssid }}</string>
  <key>PayloadIdentifier</key>
  <string>com.apple.wifi.managed.{{ sha1sum (printf "wifi-%s" .wifi.ssid) }}</string>
  <key>PayloadType</key>
  <string>com.apple.wifi.managed</string>
  <key>PayloadUUID</key>
  <string>{{ sha1sum (printf "wifi-%s" .wifi.ssid) }}</string>
  <key>PayloadVersion</key>
  <integer>1</integer>
  <key>ProxyType</key>
  <string>None</string>
  <key>SSID_STR</key>
  <string>{{ .wifi.ssid }}</string>
</dict>
{{- end }}
