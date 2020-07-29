###  sodafoundation/backend/block/repo/clean.sls
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

sodafoundation backend block repo {{ id }} ensure directory removed:
  file.absent:
    - name: {{ s.dir.sushi + '/' + id }}

      {%- endfor %}
  {%- endif %}
