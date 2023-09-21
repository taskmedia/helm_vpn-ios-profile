{{/*
VPN list of concatenated VPNs for a user.
*/}}
{{- define "vpn.list" -}}
- address: {{ print .root.Values.vpnserver.vpn.dns_name }}
  psk: {{ print .root.Values.vpnserver.vpn.psk }}
  username: {{ .user.username }}
  password: {{ .user.password }}
{{- $username := .user.username -}}
{{- range .root.Values.vpnserver.users -}}
{{- if and (eq .username $username) (.additionalVpns) }}
{{ toYaml .additionalVpns }}
{{- end }}
{{- end }}
{{- end }}
