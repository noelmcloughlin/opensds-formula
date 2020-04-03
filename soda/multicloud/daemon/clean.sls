###  soda/multicloud/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from 'soda/files/macros.j2' import daemon_clean with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.multicloud.ids %}
            {%- if 'keystone' in soda.multicloud.daemon[id]|lower %}
#include:
#  - devstack.remove

            {%- elif 'daemon' in soda.multicloud and id in soda.multicloud.daemon %}
                {%- if soda.multicloud.daemon[id] is mapping %}

{{ daemon_clean('soda', 'multicloud daemon', id, soda.multicloud, soda.systemd) }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
   {%- endif %}
