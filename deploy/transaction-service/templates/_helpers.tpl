{{- define "transaction-service.name" -}}
{{- default "transaction-service" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "transaction-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "transaction-service" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "transaction-service.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | quote }}
{{ include "transaction-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/component: transaction
{{- end }}

{{- define "transaction-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "transaction-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
