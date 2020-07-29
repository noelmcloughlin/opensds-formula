###  sodafoundation/backend/block/repo/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

  {%- if s.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import golang with context %}
{%- from 'sodafoundation/files/macros.j2' import repo_download with context %}

      {%- if s.backend.block.ids is iterable and s.backend.block.ids is string %}
          {%- set backends = s.backend.block.ids.split(', ') %}
      {%- else %}
          {%- set backends = s.backend.block.ids %}
      {%- endif %}
      {%- for id in backends %}
          {%- if 'daemon' in s.backend.block and id in s.backend.block.daemon %}
              {%- set daemon = s.backend.block.daemon[ id ] %}
              {%- if daemon is mapping and 'repo' in daemon.strategy|lower %}

{{ repo_download('sodafoundation', 'backend block repo', id, daemon, s.dir.sushi) }}

              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
