# Practicas-SA-B-201700936 — GitOps Repository

**Práctica 8: GitOps, Entrega Progresiva y Seguridad de la Cadena de Suministro**
Carné: 201700936

## Repositorio de código
https://github.com/gabrielmhh/Practicas-SA-B-201700936

## Estructura

| Carpeta | Contenido |
|---------|-----------|
| `apps/` | Manifiestos de ArgoCD Application (uno por servicio) |
| `deploy/` | Helm charts + values-prod.yaml actualizados por el pipeline |
| `policies/kyverno/` | Políticas de admisión de Kyverno (3 políticas) |
| `rollouts/` | Rollout de Argo (canary api-gateway) + AnalysisTemplate |
| `sealed-secrets/` | Secretos cifrados con Sealed Secrets |

## Flujo GitOps

1. Developer crea tag `git tag v1.x.x && git push --tags`
2. GitHub Actions: build ? test ? Trivy ? SBOM ? Docker push ? Cosign sign
3. Pipeline abre PR en este repo actualizando `image.tag` en `deploy/*/values-prod.yaml`
4. PR mergeado ? ArgoCD detecta cambio y Argo Rollouts inicia canary
5. Si análisis HTTP falla ? rollback automático
