###  sodafoundation/dock/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

   {%- if s.deploy_project not in ('gelato',)  %}
       {%- for id in s.dock.ids %}
           {%- if id in s.dock.daemon and "release" in s.dock.daemon[id]['strategy']|lower %} 

sodafoundation dock release {{ id }} download directory clean:
  file.absent:
    - name: {{ s.dir.hotpot }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
