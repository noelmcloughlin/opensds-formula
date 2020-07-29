###  sodafoundation/dock/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',)  %}
{%- from 'sodafoundation/files/macros.j2' import daemon_clean with context %}
{%- from "sodafoundation/map.jinja" import golang, packages with context %}

       {%- for id in s.dock.ids %}
           {%- if 'daemon' in s.dock and id in s.dock.daemon and s.dock.daemon[id] is mapping%}

{{ daemon_clean('sodafoundation', 'dock daemon', id, s.dock, s.systemd) }}

           {%- endif %}
       {%- endfor %}
    {%- endif %}
