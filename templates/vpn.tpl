{{/*
VPN list of concatenated VPNs for a user.
*/}}
{{- define "vpn.list" -}}
- address: {{ print (index .root.Values "ipsec-vpn-server" "vpn" "dns_name") }}
  psk: {{ print (index .root.Values "ipsec-vpn-server" "vpn" "psk") }}
  username: {{ .user.username }}
  password: {{ .user.password }}
{{- $username := .user.username -}}
{{- range (index .root.Values "ipsec-vpn-server" "users") -}}
{{- if and (eq .username $username) (.additionalVpns) }}
{{ toYaml .additionalVpns }}
{{- end }}
{{- end }}
{{- end }}
