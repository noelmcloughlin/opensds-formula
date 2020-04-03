# soda/controller/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',) %}

{%- from 'soda/files/macros.j2' import cleanup_files, cleanup_config with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.controller.ids %}
            {%- if "conf" in soda.controller and id in soda.controller.conf and soda.controller.conf[id] is mapping %}

{{ cleanup_config('soda', 'controller config', id, soda.conf) }}
{{ cleanup_files('soda', 'controller config', id, soda.dir.controller) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
