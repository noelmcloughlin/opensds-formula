###  soda/dock/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}
{%- from 'soda/files/macros.j2' import daemon_clean with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

       {%- for id in soda.dock.ids %}
           {%- if 'daemon' in soda.dock and id in soda.dock.daemon and soda.dock.daemon[id] is mapping%}

{{ daemon_clean('soda', 'dock daemon', id, soda.dock, soda.systemd) }}

           {%- endif %}
       {%- endfor %}
    {%- endif %}
