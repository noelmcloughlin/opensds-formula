###  sodafoundation/backend/block/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

  {%- if s.deploy_project not in ('gelato',)  %}
      {%- if s.backend.block.ids is iterable and s.backend.block.ids is string %}
          {%- set backends = s.backend.block.ids.split(', ') %}
      {%- else %}
          {%- set backends = s.backend.block.ids %}
      {%- endif %}
      {%- for id in backends %}
          {%- if id in s.backend.block.daemon and "release" in s.backend.block.daemon[id]['strategy']%} 

sodafoundation backend block release {{ id }} download directory clean:
  file.absent:
    - name: {{ s.dir.sushi }}/{{ id }}

          {%- endif %}
      {%- endfor %}
  {%- endif %}
