## Rollback Deployment

### Откат к предыдущей ревизии

Проверить существование deployment и посмотреть историю изменений

```bash
    kubectl get deployment <DEPLOYMENT_NAME> -n <NAMESPACE>
    kubectl rollout history deployment/<DEPLOYMENT_NAME> -n <NAMESPACE>
```
