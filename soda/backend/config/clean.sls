# soda/backend/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}

{%- from 'soda/files/macros.j2' import cleanup_config with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.backend.ids %}
            {%- if "conf" in soda.backend and id in soda.backend.conf %}

{{ cleanup_config('soda', 'backend config', id, soda.conf) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
