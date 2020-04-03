###  soda/nbp/plugin/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

    {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from "soda/map.jinja" import docker, packages, golang with context %}
{%- from 'soda/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'soda/files/macros.j2' import workflow, container_run, service_run with context %}

        {%- for id in soda.nbp.plugin.ids %}
            {%- if 'daemon' in soda.nbp.plugin and id in soda.nbp.plugin.daemon  %}
                {%- if soda.nbp.plugin.daemon[id] is mapping %}

{{ workflow('soda','nbp plugin daemon', id, soda.nbp.plugin, soda.dir.nbp+'/nbp', soda, golang, soda.nbp.plugin_type|string)}}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
     {%- endif %}
