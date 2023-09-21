{{- /*
Add custom certificates to iOS profile
*/}}
{{- define "certs" -}}
{{- /* Generate list of users certificates */}}
{{- $username := .user.username -}}
{{- $certs := .root.Values.certs  -}}
{{- range (index .root.Values "ipsec-vpn-server" "users") -}}
{{- if and (eq .username $username) (.certs) }}
{{- $certs = concat $certs .certs }}
{{- end }}
{{- end }}
{{- /* Template generated list of certificates */}}
{{- range $certs }}
<dict>
  <key>PayloadCertificateFileName</key>
  <string>{{ regexReplaceAll "\\W+" .name "-" }}.cer</string>
  <key>PayloadContent</key>
  <data>
    {{ ($.root.Files.Get .filename | required (printf "certificate file not fould: %s" .filename)) | b64enc }}
  </data>
  <key>PayloadDescription</key>
  <string>Adds {{ .name }} certificate</string>
  <key>PayloadDisplayName</key>
  <string>{{ .name }}</string>
  <key>PayloadIdentifier</key>
  <string>com.apple.security.root.{{ uuidv4 }}</string>
  <key>PayloadType</key>
  <string>com.apple.security.root</string>
  <key>PayloadUUID</key>
  <string>{{ uuidv4 }}</string>
  <key>PayloadVersion</key>
  <integer>1</integer>
</dict>
{{- end }}
{{- end }}