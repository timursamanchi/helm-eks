{{/*
Generate a name like <release-name>-<chart-name>
*/}}
{{- define "quote-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "quote-app.labels" -}}
app.kubernetes.io/name: {{ include "quote-app.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels — used in both Deployment and Service
*/}}
{{- define "quote-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quote-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Chart name — fallback if fullnameOverride not used
*/}}
{{- define "quote-app.name" -}}
{{- .Chart.Name }}
{{- end }}

{{/*
ServiceAccount name
*/}}
{{- define "quote-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "quote-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
