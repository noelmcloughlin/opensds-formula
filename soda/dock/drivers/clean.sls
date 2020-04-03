# soda/backend/drivers/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- for id in soda.backend.ids %}
      {%- if id in soda.backend.drivers %}

        ################
        # <driver>.yaml
        ################
soda backend drivers {{ id }} remove driver file:
  file.absent:
    - name: {{ soda.dir.driver }}/{{ id }}.yaml

      {%- endif %}
  {%- endfor %}
