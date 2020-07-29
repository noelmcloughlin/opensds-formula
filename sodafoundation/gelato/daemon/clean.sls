###  sodafoundation/gelato/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

    {%- if sodafoundation.deploy_project not in ('gelato',)  %}

{%- from 'sodafoundation/files/macros.j2' import daemon_clean with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

        {%- for id in sodafoundation.gelato.ids %}
            {%- if 'keystone' in sodafoundation.gelato.daemon[id]|lower %}
#include:
#  - devstack.remove

            {%- elif 'daemon' in sodafoundation.gelato and id in sodafoundation.gelato.daemon %}
                {%- if sodafoundation.gelato.daemon[id] is mapping %}

{{ daemon_clean('sodafoundation', 'gelato daemon', id, sodafoundation.gelato, sodafoundation.systemd) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
   {%- endif %}
