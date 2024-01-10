#!/bin/bash

backup_file="backup_$(date +"%d.%m.%Y").sql"

kubectl exec -it postgresql -n  -- /bin/bash -c "PGPASSWORD= pg_dump -U 123 -d 123 -p 1234"  > $backup_file


if [ $? -eq 0 ]; then
    echo "Команда kubectl exec выполнена успешно"
else
    echo "Произошла ошибка при выполнении команды kubectl exec"
    exit 1
fi

s3cmd put $backup_file s3://backup/$backup_file

if [ $? -eq 0 ]; then
    echo "Файл успешно скопирован в S3 бакет"
else
    echo "Произошла ошибка при копировании файла в S3 бакет"
    exit 1
fi

