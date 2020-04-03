###  soda/api/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}
{%- from 'soda/files/macros.j2' import daemon_clean with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

       {%- for id in soda.api.ids %}
           {%- if 'daemon' in soda.api and id in soda.api.daemon and soda.api.daemon[id] is mapping%}

{{ daemon_clean('soda', 'api daemon', id, soda.api, soda.systemd) }}

           {%- endif %}
       {%- endfor %}
    {%- endif %}
