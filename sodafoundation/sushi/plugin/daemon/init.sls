###  sodafoundation/sushi/plugin/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('gelato',)  %}

{%- from "sodafoundation/map.jinja" import docker, packages, golang with context %}
{%- from 'sodafoundation/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'sodafoundation/files/macros.j2' import workflow, container_run, service_run with context %}

        {%- for id in s.sushi.plugin.ids %}
            {%- if 'daemon' in s.sushi.plugin and id in s.sushi.plugin.daemon  %}
                {%- if s.sushi.plugin.daemon[id] is mapping %}

{{ workflow('sodafoundation','sushi plugin daemon', id, s.sushi.plugin, s.dir.sushi+'/nbp', s, golang, s.sushi.plugin_type|string)}}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
     {%- endif %}
