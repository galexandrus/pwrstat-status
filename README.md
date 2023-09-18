# pwrstat-status
grafana+prometheus monitoring system for UPS CyberPower UT650EG

Для контроля уровня напряжения в сети можно организовать мониторинг с использованием grafana и prometheus.
Система работает следующим образом: 
<br>cron выполняет скрипт bash,
<br>идёт обращение к UPS CyberPower UT650EG, далее с помощью awk обрабатывается ответ UPS,
<br>итог записывается в файл, а prometheus считывает данные из этого файла.

На localhost нужно установить: grafana, prometheus, node_exporter.
<a href="https://www.youtube.com/playlist?list=PLoRLk9325TJLaKTTeJYLLctA_ibGnp58_">Инструкции по установке prometheus, node_exporter на превосходном "стандартном" английском</a>

Создать конфигурационные файлы для systemctl:
<br>-rw-r--r--. 1 root root 356 Feb 22 17:07 /etc/systemd/system/node_exporter.service
<br>-rw-r--r--. 1 root root 433 Feb 22 10:28 /etc/systemd/system/prometheus.service

Исполняемые файлы prometheus, promtool, node_exporter поместить сюда:
<br>/usr/local/bin

В каталоге /etc/prometheus в конфигурацию по умолчанию для prometheus добавить:
```
  - job_name: "node_exporter"
    scrape_interval: 10s
    scrape_timeout: 5s
    static_configs:
      - targets: ["localhost:9100"]
```

Кроме того, здесь же изменить следующие параметры:
```
global:
  scrape_interval: 60s
  evaluation_interval: 60s
```

В каталоге /var/log/pwrstat создать файлы:
<br>pwrstat-node.awk - команда awk для обработки вывода команды "pwrstat -status"
<br>pwrstat-status.sh - скрипт, который выполняется службой crond.service
<br>pwrstat.prom - текстовый файл, откуда prometheus считывает данные

И добавить строчку в /etc/crontab
