{% from "pagespeed/map.jinja" import pagespeed with context %}

pagespeed:
  pkg.installed:
    - refresh: True
    - pkgs:
      {{ pagespeed.pkgs | yaml(False) | indent(6) }}

pagespeed_defaults_config:
  file.managed:
    - name: /etc/default/pagespeed-exporter
    - source: salt://pagespeed/templates/pagespeed.default
    - template: jinja
    - require:
      - pkg: pagespeed

pagespeed_service:
  service.running:
    - name: pagespeed-exporter
    - enable: True
    - require:
      - pkg: pagespeed
    - watch:
      - file: pagespeed_defaults_config
