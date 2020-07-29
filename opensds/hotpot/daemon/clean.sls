###  sodafoundation/hotpot/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

{%- from 'sodafoundation/files/macros.j2' import daemon_clean with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in sodafoundation.hotpot.ids %}
            {%- if 'daemon' in sodafoundation.hotpot and id in sodafoundation.hotpot.daemon  %}
                {%- if sodafoundation.hotpot.daemon[id] is mapping %}

{{ daemon_clean('sodafoundation', 'hotpot daemon', id, sodafoundation.hotpot, sodafoundation.systemd) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
