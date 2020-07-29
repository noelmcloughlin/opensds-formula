# sodafoundation/dashboard/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',) %}

{%- from 'sodafoundation/files/macros.j2' import cleanup_files, cleanup_config with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in s.dashboard.ids %}
            {%- if "conf" in s.dashboard and id in s.dashboard.conf %}

{{ cleanup_config('sodafoundation', 'dashboard config', id, s.conf) }}
{{ cleanup_files('sodafoundation', 'dashboard config', id, s.dir.dashboard) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
