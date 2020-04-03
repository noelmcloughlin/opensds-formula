# soda/backend/drivers/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- set driver = {} %}
  {%- for id in soda.backend.ids %}
      {%- if id in soda.backend.drivers %}
          {%- set driver = soda.backend.drivers[id] %}
          {#- if salt['file.file_exists']( tpldir ~ '/yaml/' ~ id ~ '.yaml') #}

              {%- import_yaml tpldir ~ '/yaml/' ~ id ~ '.yaml' as driver_yaml %}
              {%- do salt['defaults.merge'](driver_yaml, soda.backend.drivers[id], merge_lists=True) %}
              {%- do driver.update( driver_yaml ) %}

        ##################
        ####  driver.conf
        ##################
soda backend driver {{ id }} generate driver file:
  file.managed:
    - name: {{ soda.dir.driver }}/{{ id }}.yaml
    - source: salt://soda/dock/drivers/yaml/template.jinja
    - template: jinja
    - user: {{ soda.user or 'root' }}
    - mode: {{ soda.file_mode }}
    - context:
      driver: {{ driver }}

          {#- endif #}
      {%- endif %}
  {%- endfor %}
