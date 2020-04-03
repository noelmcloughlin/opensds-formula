###  soda/nbp/plugin/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}
{%- from 'soda/files/macros.j2' import daemon_clean with context %}
{%- from "soda/map.jinja" import golang, packages with context %}

        {%- for id in soda.nbp.plugin.ids %}
           {%- if 'daemon' in soda.nbp.plugin and id in soda.nbp.plugin.daemon and soda.nbp.plugin.daemon[ id ] is mapping %}

{{ daemon_clean('soda', 'nbp plugin daemon', id, soda.nbp.plugin, soda.systemd, soda.nbp.plugin_type) }}

           {%- endif %}
        {%- endfor %}
    {%- endif %}
