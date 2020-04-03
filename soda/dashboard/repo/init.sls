###  soda/dashboard/repo/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from "soda/map.jinja" import golang with context %}
{%- from 'soda/files/macros.j2' import repo_download with context %}

        {%- for id in soda.dashboard.ids %}
            {%- if id in soda.dashboard.daemon and soda.dashboard.daemon[ id ] is mapping %}
                {%- set daemon = soda.dashboard.daemon[ id ] %}
                {%- if daemon is mapping and 'repo' in daemon.strategy|lower %}

{{ repo_download('soda', 'dashboard repo', id, daemon, golang.go_path + '/src/github.com/soda/') }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
