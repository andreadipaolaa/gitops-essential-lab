{{- define "nginx.labels" -}}
app.kubernetes.io/name: {{ include "nginx.name" . }}
helm.sh/chart: {{ include "nginx.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "nginx.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{- define "nginx.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{- define "nginx.fullname" -}}
{{ printf "%s-%s" .Release.Name (include "nginx.name" .) }}
{{- end -}}
