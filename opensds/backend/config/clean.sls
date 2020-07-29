# sodafoundation/backend/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',) %}

{%- from 'sodafoundation/files/macros.j2' import cleanup_config with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in s.backend.ids %}
            {%- if "conf" in s.backend and id in s.backend.conf %}

{{ cleanup_config('sodafoundation', 'backend config', id, s.conf) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
