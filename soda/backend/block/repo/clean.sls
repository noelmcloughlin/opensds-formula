###  soda/backend/block/repo/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- if soda.deploy_project not in ('multicloud',)  %}
      {%- if soda.backend.block.ids is iterable and soda.backend.block.ids is string %}
          {%- set backends = soda.backend.block.ids.split(', ') %}
      {%- else %}
          {%- set backends = soda.backend.block.ids %}
      {%- endif %}
      {%- for id in backends %}

soda backend block repo {{ id }} ensure directory removed:
  file.absent:
    - name: {{ soda.dir.nbp + '/' + id }}

      {%- endfor %}
  {%- endif %}
