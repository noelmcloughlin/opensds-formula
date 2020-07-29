###  sodafoundation/sushi/plugin/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

{%- if s.deploy_project not in ('gelato',)  %}
    {%- from 'sodafoundation/files/macros.j2' import daemon_clean with context %}
    {%- from "sodafoundation/map.jinja" import golang, packages with context %}

    {%- for id in s.sushi.plugin.ids %}
        {%- if 'daemon' in s.sushi.plugin and id in s.sushi.plugin.daemon and s.sushi.plugin.daemon[id] is mapping %}

{{ daemon_clean('sodafoundation', 'sushi plugin daemon', id, s.sushi.plugin, s.systemd, s.sushi.plugin_type) }}

        {%- endif %}
    {%- endfor %}
{%- endif %}
