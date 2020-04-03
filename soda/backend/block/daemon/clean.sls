###  soda/backend/block/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from 'soda/files/macros.j2' import daemon_clean with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

      {%- if soda.backend.block.ids is iterable and soda.backend.block.ids is string %}
          {%- set backends = soda.backend.block.ids.split(', ') %}
      {%- else %}
          {%- set backends = soda.backend.block.ids %}
      {%- endif %}
      {%- for id in backends %}
          {%- if 'daemon' in soda.backend.block and id in soda.backend.block.daemon  %}  
              {%- if soda.backend.block.daemon[ id ] is mapping %}

{{ daemon_clean('soda', 'backend block daemon', id, soda.backend.block, soda.systemd) }}

              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
