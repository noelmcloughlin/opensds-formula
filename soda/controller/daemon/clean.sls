###  soda/controller/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from 'soda/files/macros.j2' import daemon_clean with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.controller.ids %}
            {%- if 'daemon' in soda.controller and id in soda.controller.daemon  %}
                {%- if soda.controller.daemon[id] is mapping %}

{{ daemon_clean('soda', 'controller daemon', id, soda.controller, soda.systemd) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
