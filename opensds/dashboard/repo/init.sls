###  sodafoundation/dashboard/repo/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import golang with context %}
{%- from 'sodafoundation/files/macros.j2' import repo_download with context %}

        {%- for id in s.dashboard.ids %}
            {%- if id in s.dashboard.daemon and s.dashboard.daemon[ id ] is mapping %}
                {%- set daemon = s.dashboard.daemon[ id ] %}
                {%- if daemon is mapping and 'repo' in daemon.strategy|lower %}

{{ repo_download('sodafoundation', 'dashboard repo', id, daemon, golang.go_path + '/src/github.com/sodafoundation/') }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
