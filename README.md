# Terraform инфраструктура для Digital Ocean
Этот репозиторий содержит модульную конфигурацию для развертывания облачной инфраструктуры. Состоит из 2 модулей: compute(для разворачивания droplet) и network (VPC и firewall)

## Требования
Перед началом работы нужно:
1. создать Spaces Object Storage для хранения state файлов
    - отредактировать файл backend.tf, указав имя bucket, ключ , регион , entrypoint
    - При создании workspace в bucket записывается state-файл для окружения
    ```bash
        terraform workspace new staging
        terraform workspace new prod
    ```

2. создать PAT для доступа к API Digital Ocean с правами read и write
3. ssh-ключ для прокидывания на droplet(vm) для разворачивания  k8s кластера

## Инициализация и запуск
Инициализируйте Terraform и установите провайдеры:
  
    ```bash
        terraform init
    ```

Затем запускаем plan c указанием файла со значениями переменных. Для staging окружения указываем путь к staging.tfvars
```
terraform plan -var-file=environments/production.tfvars 
terraform apply -var-file=environments/production.tfvars 
```
Проверяем в облаке, все ли создалось