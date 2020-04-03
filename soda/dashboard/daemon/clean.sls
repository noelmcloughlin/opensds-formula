###  soda/dashboard/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}
{%- from 'soda/files/macros.j2' import daemon_clean with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.dashboard.ids %}
            {%- if 'daemon' in soda.dashboard and id in soda.dashboard.daemon and soda.dashboard.daemon[ id ] is mapping %}

{{ daemon_clean('soda', 'dashboard daemon', id, soda.dashboard, soda.systemd) }}

                    {%- if 'build' in soda.dashboard.daemon[id]['strategy']|lower %}
soda dashboard config {{ id }} clean angular cli:
  cmd.run:
    - name: npm uninstall -g @angular/cli
    - env:
       - GOPATH: {{ golang.go_path }}
    - onlyif:
      - npm --version 2>/dev/null
      - {{ id|lower == 'dashboard' }}
                    {%- endif %}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
