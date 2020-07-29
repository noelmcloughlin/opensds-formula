# sodafoundation/hotpot/config/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',) %}

{%- from 'sodafoundation/files/macros.j2' import cleanup_files, cleanup_config with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in s.hotpot.ids %}
            {%- if "conf" in s.hotpot and id in s.hotpot.conf and s.hotpot.conf[id] is mapping %}

{{ cleanup_config('sodafoundation', 'hotpot config', id, s.conf) }}
{{ cleanup_files('sodafoundation', 'hotpot config', id, s.dir.hotpot) }}

            {%- endif %}
        {%- endfor %}
    {%- endif %}
