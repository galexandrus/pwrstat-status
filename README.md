# pwrstat-status
grafana+prometheus monitoring system for UPS CyberPower UT650EG

Для контроля уровня напряжения в сети можно организовать мониторинг с использованием grafana и prometheus.
Система работает следующим образом: 
<br>cron выполняет скрипт bash,
<br>идёт обращение к UPS CyberPower UT650EG, далее с помощью awk обрабатывается ответ UPS,
<br>итог записывается в файл, а prometheus считывает данные из этого файла.

На localhost нужно установить: grafana, prometheus, node_exporter.
<br>Инструкции по установке prometheus, node_exporter на превосходном "стандартном" английском:
<br>https://www.youtube.com/playlist?list=PLoRLk9325TJLaKTTeJYLLctA_ibGnp58_

Создать конфигурационные файлы для systemctl:
<br>-rw-r--r--. 1 root root 356 Feb 22 17:07 /etc/systemd/system/node_exporter.service
<br>-rw-r--r--. 1 root root 433 Feb 22 10:28 /etc/systemd/system/prometheus.service

Исполняемые файлы prometheus, promtool, node_exporter поместить сюда:
<br>/usr/local/bin

В каталоге /etc/prometheus в конфигурацию по умолчанию для prometheus добавить:
<br>  - job_name: "node_exporter"
<br>    scrape_interval: 10s
<br>    scrape_timeout: 5s
<br>    static_configs:
<br>      - targets: ["localhost:9100"]

Кроме того, здесь же изменить следующие параметры:
<br>global:
<br>  scrape_interval: 60s
<br>  evaluation_interval: 60s

В каталоге /var/log/pwrstat создать файлы:
<br>pwrstat-node.awk - команда awk для обработки вывода команды "pwrstat -status"
<br>pwrstat-status.sh - скрипт, который выполняется службой crond.service
<br>pwrstat.prom - текстовый файл, откуда prometheus считывает данные

