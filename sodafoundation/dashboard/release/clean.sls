###  sodafoundation/dashboard/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

   {%- if s.deploy_project not in ('gelato',)  %}
       {%- for id in s.dashboard.ids %}
           {%- if id in s.dashboard.daemon and 'release' in s.dashboard.daemon[id]['strategy'] %} 

sodafoundation dashboard release {{ id }} download directory clean:
  file.absent:
    - name: {{ s.dir.dashboard }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
