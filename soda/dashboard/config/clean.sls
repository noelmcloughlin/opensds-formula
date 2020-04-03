# soda/dashboard/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}

{%- from 'soda/files/macros.j2' import cleanup_files, cleanup_config with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.dashboard.ids %}
            {%- if "conf" in soda.dashboard and id in soda.dashboard.conf %}

{{ cleanup_config('soda', 'dashboard config', id, soda.conf) }}
{{ cleanup_files('soda', 'dashboard config', id, soda.dir.dashboard) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
