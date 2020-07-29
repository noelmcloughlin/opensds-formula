# sodafoundation/backend/drivers/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

  {%- for id in sodafoundation.backend.ids %}
      {%- if id in sodafoundation.backend.drivers %}

        ################
        # <driver>.yaml
        ################
sodafoundation backend drivers {{ id }} remove driver file:
  file.absent:
    - name: {{ sodafoundation.dir.driver }}/{{ id }}.yaml

      {%- endif %}
  {%- endfor %}
