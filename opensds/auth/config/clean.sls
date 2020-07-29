# sodafoundation/auth/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',) %}
{%- from 'sodafoundation/files/macros.j2' import cleanup_config, cleanup_files with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in sodafoundation.auth.ids %}
            {%- if "conf" in sodafoundation.auth and id in sodafoundation.auth.conf %}

{{ cleanup_config('sodafoundation', 'auth config', id, sodafoundation.conf)}}
{{ cleanup_files('sodafoundation', 'auth config', id) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
