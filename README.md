# pwrstat-status
grafana+prometheus monitoring system for UPS CyberPower UT650EG

Для контроля уровня напряжения в сети можно организовать мониторинг с использованием grafana и prometheus.
Система работает следующим образом: 
<p>cron выполняет скрипт bash,
<p>идёт обращение к UPS CyberPower UT650EG, далее с помощью awk обрабатывается ответ UPS,
<p>итог записывается в файл, а prometheus считывает данные из этого файла.

На localhost нужно установить: grafana, prometheus, node_exporter.
<p>Инструкции по установке prometheus, node_exporter на превосходном "стандартном" английском:
<p>https://www.youtube.com/playlist?list=PLoRLk9325TJLaKTTeJYLLctA_ibGnp58_

Создать конфигурационные файлы для systemctl:
<p>-rw-r--r--. 1 root root 356 Feb 22 17:07 /etc/systemd/system/node_exporter.service
<p>-rw-r--r--. 1 root root 433 Feb 22 10:28 /etc/systemd/system/prometheus.service

Исполняемые файлы prometheus, promtool, node_exporter поместить сюда:
<p>/usr/local/bin

В каталоге /etc/prometheus в конфигурацию по умолчанию для prometheus добавить:
<p>  - job_name: "node_exporter"
<p>    scrape_interval: 10s
<p>    scrape_timeout: 5s
<p>    static_configs:
<p>      - targets: ["localhost:9100"]

Кроме того, здесь же изменить следующие параметры:
<p>global:
<p>  scrape_interval: 60s
<p>  evaluation_interval: 60s

В каталоге /var/log/pwrstat создать файлы:
<p>pwrstat-node.awk - команда awk для обработки вывода команды "pwrstat -status"
<p>pwrstat-status.sh - скрипт, который выполняется службой crond.service
<p>pwrstat.prom - текстовый файл, откуда prometheus считывает данные

