{{- /*
Add custom certificates to iOS profile
*/}}
{{- define "certs" -}}
{{- /* Generate list of users certificates */}}
{{- $username := .user.username -}}
{{- $certs := .root.Values.certs  -}}
{{- range .root.Values.vpnserver.users }}
{{- if and (eq .username $username) (.certs) }}
{{- $certs = concat $certs .certs }}
{{- end }}
{{- end }}
{{- /* Template generated list of certificates */}}
{{- range $certs }}
{{- $certType := "pkcs1" }}
{{- if eq "p12" ((splitList "." .filename) | last) }}
{{- $certType = "pkcs12" }}
{{- end }}
<dict>
  <key>PayloadCertificateFileName</key>
  <string>{{ .filename }}</string>
  <key>PayloadContent</key>
  <data>
    {{ ($.root.Files.Get .filename | required (printf "certificate file not fould: %s" .filename)) | b64enc }}
  </data>
  <key>PayloadDescription</key>
  <string>Adds {{ .name }} certificate</string>
  <key>PayloadDisplayName</key>
  <string>{{ .name }}</string>
  <key>PayloadIdentifier</key>
  <string>com.apple.security.{{ $certType }}.{{ sha1sum (printf "cert-%s" .name) }}</string>
  <key>PayloadType</key>
  <string>com.apple.security.{{ $certType }}</string>
  <key>PayloadUUID</key>
  <string>{{ sha1sum (printf "cert-%s" .name) }}</string>
  <key>PayloadVersion</key>
  <integer>1</integer>
</dict>
{{- end }}
{{- end }}
