###  sodafoundation/dashboard/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import packages, docker, golang with context %}
{%- from 'sodafoundation/files/macros.j2' import build_source, copy_build with context %}
{%- from 'sodafoundation/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - s.dashboard.config

        {%- for id in s.dashboard.ids %}
            {%- if 'daemon' in s.dashboard and id in s.dashboard.daemon  %}
                {%- if s.dashboard.daemon[ id ] is mapping %}

                    {%- if 'container' in s.dashboard.daemon[ id ]['strategy']|lower %}
sodafoundation dashboard daemon {{ id }} ensure nginx stopped and disabled:
  service.dead:
    - name: nginx
    - enable: False
                    {%- endif %}

                    {%- if 'build' in s.dashboard.daemon[ id ]['strategy']|lower %}
sodafoundation dashboard config install angular cli:
  cmd.run:
    - name: 'npm install -g @angular/cli'
    - env:
      - GOPATH: {{ golang.go_path }}
    - onlyif:
      - npm --version 2>/dev/null
      - {{ id|lower == 'dashboard' }}
   - unless: {{ 'container' in s.dashboard.daemon[ id ]|lower }}
                    {%- endif %}

{{ workflow('sodafoundation', 'dashboard daemon', id, s.dashboard, s.dir.dashboard, sodafoundation, golang) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
