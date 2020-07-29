###  sodafoundation/gelato/repo/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('hotpot',) %}

{%- from "sodafoundation/map.jinja" import golang with context %}
{%- from 'sodafoundation/files/macros.j2' import repo_download with context %}

        {%- for id in sodafoundation.gelato.ids %}
            {%- if id in sodafoundation.gelato.daemon and sodafoundation.gelato.daemon[ id ] is mapping %}
                {%- set daemon = sodafoundation.gelato.daemon[ id ] %}
                {%- if daemon is mapping and 'repo' in daemon.strategy|lower %}

{{ repo_download('sodafoundation', 'gelato repo', id, daemon, golang.go_path + '/src/github.com/sodafoundation') }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
