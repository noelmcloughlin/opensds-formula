# sodafoundation/backend/drivers/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

  {%- set driver = {} %}
  {%- for id in s.backend.ids %}
      {%- if id in s.backend.drivers %}
          {%- set driver = s.backend.drivers[id] %}
          {#- if salt['file.file_exists']( tpldir ~ '/yaml/' ~ id ~ '.yaml') #}

              {%- import_yaml tpldir ~ '/yaml/' ~ id ~ '.yaml' as driver_yaml %}
              {%- do salt['defaults.merge'](driver_yaml, s.backend.drivers[id], merge_lists=True) %}
              {%- do driver.update( driver_yaml ) %}

        ##################
        ####  driver.conf
        ##################
sodafoundation backend driver {{ id }} generate driver file:
  file.managed:
    - name: {{ s.dir.driver }}/{{ id }}.yaml
    - source: salt://sodafoundation/dock/drivers/yaml/template.jinja
    - template: jinja
    - user: {{ s.user or 'root' }}
    - mode: {{ s.file_mode }}
    - context:
      driver: {{ driver }}

          {#- endif #}
      {%- endif %}
  {%- endfor %}
