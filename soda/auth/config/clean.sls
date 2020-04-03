# soda/auth/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}
{%- from 'soda/files/macros.j2' import cleanup_config, cleanup_files with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.auth.ids %}
            {%- if "conf" in soda.auth and id in soda.auth.conf %}

{{ cleanup_config('soda', 'auth config', id, soda.conf)}}
{{ cleanup_files('soda', 'auth config', id) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
