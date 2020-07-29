# sodafoundation/database/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',) %}
{%- from 'sodafoundation/files/macros.j2' import cleanup_config with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in sodafoundation.database.ids %}
            {%- if "conf" in sodafoundation.database and id in sodafoundation.database.conf %}

{{ cleanup_config('sodafoundation', 'database config', id, sodafoundation.conf)}}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
