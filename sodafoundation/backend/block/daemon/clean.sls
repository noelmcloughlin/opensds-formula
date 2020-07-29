###  sodafoundation/backend/block/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

  {%- if sodafoundation.deploy_project not in ('gelato',)  %}

{%- from 'sodafoundation/files/macros.j2' import daemon_clean with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

      {%- if sodafoundation.backend.block.ids is iterable and sodafoundation.backend.block.ids is string %}
          {%- set backends = sodafoundation.backend.block.ids.split(', ') %}
      {%- else %}
          {%- set backends = sodafoundation.backend.block.ids %}
      {%- endif %}
      {%- for id in backends %}
          {%- if 'daemon' in sodafoundation.backend.block and id in sodafoundation.backend.block.daemon  %}  
              {%- if sodafoundation.backend.block.daemon[ id ] is mapping %}

{{ daemon_clean('sodafoundation', 'backend block daemon', id, sodafoundation.backend.block, sodafoundation.systemd) }}

              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
