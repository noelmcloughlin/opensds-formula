###  soda/backend/block/repo/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from "soda/map.jinja" import golang with context %}
{%- from 'soda/files/macros.j2' import repo_download with context %}

      {%- if soda.backend.block.ids is iterable and soda.backend.block.ids is string %}
          {%- set backends = soda.backend.block.ids.split(', ') %}
      {%- else %}
          {%- set backends = soda.backend.block.ids %}
      {%- endif %}
      {%- for id in backends %}
          {%- if 'daemon' in soda.backend.block and id in soda.backend.block.daemon %}
              {%- set daemon = soda.backend.block.daemon[ id ] %}
              {%- if daemon is mapping and 'repo' in daemon.strategy|lower %}

{{ repo_download('soda', 'backend block repo', id, daemon, soda.dir.nbp) }}

              {%- endif %}
          {%- endif %}
      {%- endfor %}
  {%- endif %}
