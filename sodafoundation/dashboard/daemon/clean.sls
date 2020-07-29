###  sodafoundation/dashboard/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',)  %}
{%- from 'sodafoundation/files/macros.j2' import daemon_clean with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in s.dashboard.ids %}
            {%- if 'daemon' in s.dashboard and id in s.dashboard.daemon and s.dashboard.daemon[ id ] is mapping %}

{{ daemon_clean('sodafoundation', 'dashboard daemon', id, s.dashboard, s.systemd) }}

                    {%- if 'build' in s.dashboard.daemon[id]['strategy']|lower %}
sodafoundation dashboard config {{ id }} clean angular cli:
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
