# soda/database/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}
{%- from 'soda/files/macros.j2' import cleanup_config with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.database.ids %}
            {%- if "conf" in soda.database and id in soda.database.conf %}

{{ cleanup_config('soda', 'database config', id, soda.conf)}}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
