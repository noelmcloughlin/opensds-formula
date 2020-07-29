###  sodafoundation/hotpot/repo/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import golang with context %}
{%- from 'sodafoundation/files/macros.j2' import repo_download with context %}

        {%- for id in sodafoundation.hotpot.ids %}
            {%- if id in sodafoundation.hotpot.daemon and sodafoundation.hotpot.daemon[ id ] is mapping %}
                {%- set daemon = sodafoundation.hotpot.daemon[ id ] %}
                {%- if daemon is mapping and 'repo' in daemon.strategy|lower %}

{{ repo_download('sodafoundation', 'hotpot repo', id, daemon, golang.go_path + '/src/github.com/sodafoundation') }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
