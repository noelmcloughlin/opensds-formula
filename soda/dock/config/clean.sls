# soda/dock/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}

{%- from 'soda/files/macros.j2' import cleanup_files, cleanup_config with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.dock.ids %}
            {%- if "conf" in soda.dock and id in soda.dock.conf %}

{{ cleanup_config('soda', 'dock config', id, soda.conf)}}
{{ cleanup_files('soda', 'dock config', id, None, ['sodadock',]) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
