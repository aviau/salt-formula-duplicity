duplicity:
  pkg:
    - installed

python-boto:
  pkg:
    - installed

cron:
  pkg:
    - installed

{% for job, config in salt['pillar.get']('duplicity:jobs', {}).items() %}

duplicity_job_{{ job }}:
  file.managed:
    - name: /etc/cron.daily/duplicity_{{ job }}.sh
    - user: root
    - group: root
    - mode: 770
    - source: salt://duplicity/files/job.jinja
    - template: jinja
    - context:
        job: {{ job }}
        config: {{ config }}

{% endfor %}
