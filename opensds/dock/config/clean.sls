# sodafoundation/dock/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',) %}

{%- from 'sodafoundation/files/macros.j2' import cleanup_files, cleanup_config with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in sodafoundation.dock.ids %}
            {%- if "conf" in sodafoundation.dock and id in sodafoundation.dock.conf %}

{{ cleanup_config('sodafoundation', 'dock config', id, sodafoundation.conf)}}
{{ cleanup_files('sodafoundation', 'dock config', id, None, ['osdsdock',]) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
