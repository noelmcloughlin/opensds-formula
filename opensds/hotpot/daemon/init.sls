###  sodafoundation/hotpot/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

  {%- if s.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import packages, docker, golang with context %}
{%- from 'sodafoundation/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'sodafoundation/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - s.hotpot.config

      {%- for id in s.hotpot.ids %}
          {% if 'daemon' in s.hotpot and id in s.hotpot.daemon and s.hotpot.daemon[id] is mapping %}

{{ workflow('sodafoundation', 'hotpot daemon', id, s.hotpot, s.dir.hotpot, sodafoundation, golang) }}

          {%- endif %}
      {%- endfor %}
  {%- endif %}
