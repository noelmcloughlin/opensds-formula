###  soda/backend/block/release/clean.sls
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
          {%- if id in soda.backend.block.daemon and "release" in soda.backend.block.daemon[id]['strategy']%} 

soda backend block release {{ id }} download directory clean:
  file.absent:
    - name: {{ soda.dir.nbp }}/{{ id }}

          {%- endif %}
      {%- endfor %}
  {%- endif %}
