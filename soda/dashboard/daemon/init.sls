###  soda/dashboard/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from "soda/map.jinja" import packages, docker, golang with context %}
{%- from 'soda/files/macros.j2' import build_source, copy_build with context %}
{%- from 'soda/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - soda.dashboard.config

        {%- for id in soda.dashboard.ids %}
            {%- if 'daemon' in soda.dashboard and id in soda.dashboard.daemon  %}
                {%- if soda.dashboard.daemon[ id ] is mapping %}

                    {%- if 'container' in soda.dashboard.daemon[ id ]['strategy']|lower %}
soda dashboard daemon {{ id }} ensure nginx stopped and disabled:
  service.dead:
    - name: nginx
    - enable: False
                    {%- endif %}

                    {%- if 'build' in soda.dashboard.daemon[ id ]['strategy']|lower %}
soda dashboard config install angular cli:
  cmd.run:
    - name: 'npm install -g @angular/cli'
    - env:
      - GOPATH: {{ golang.go_path }}
    - onlyif:
      - npm --version 2>/dev/null
      - {{ id|lower == 'dashboard' }}
   - unless: {{ 'container' in soda.dashboard.daemon[ id ]|lower }}
                    {%- endif %}

{{ workflow('soda', 'dashboard daemon', id, soda.dashboard, soda.dir.dashboard, soda, golang) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
