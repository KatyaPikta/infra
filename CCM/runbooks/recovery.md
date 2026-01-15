## Полное восстановление кластера

### Требования

-  Полный бэкап кластера (с включением всех namespaces)

### Разворачиваем инфраструктуру (или восстанавливаем) 

- запускаем terraform - для разоврачивания инфраструктуры (или изменения настроек в соответствии с требуемыми)

    ```bash
    terraform plan -var-file=environments/production.tfvars 
    terraform apply -var-file=environments/production.tfvars
    ```

- запускаем kubespray для конфигурации кластера k8s (или реконфигурации)

- устанавливаем и настраиваем Velero в новом кластере (с тем же storage location? где лежат бэкапы).

### Восстанавливаем backup

```bash
 velero restore create --from-backup <backup-name>
 ```

- проверяем восстановление

    ```bash
    velero restore describe <restore-name>
    velero restore logs <restore-name>
    kubectl get pvc -A
    kubectl get pv -A
    ```

- если pvc не восстановились, можно запустить принудительное восстановление

    ```bash
    velero restore create --from-backup <backup-name> --restore-volumes=true
    ```


## Восстановление конкретного приложения

- ### Восстановление в тот же namespace

    - Удалить старый namespace
    - Запустить восстановление приложения из namespace

    ```bash
    velero restore create <RESTORE_NAME> \
    --from-backup <BACKUP_NAME> \
    --include-namespaces <NAMESPACE> \
    --wait
    ```

- ### Восстановление в новый namespace

    - Создать новый namespace
    - Запустить восстановление приложения из namespace

    ```bash
    velero restore create <RESTORE_NAME> \
    --from-backup <BACKUP_NAME> \
    --include-namespaces <NAMESPACE> \
    --wait
    ```
