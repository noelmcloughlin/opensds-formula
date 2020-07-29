###  sodafoundation/gelato/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

   {%- if s.deploy_project not in ('hotpot',)  %}
       {%- for id in s.gelato.ids %}
           {%- if id in s.gelato.daemon and 'release' in s.gelato.daemon[id]['strategy']|lower %} 

sodafoundation gelato release {{ id }} download directory clean:
  file.absent:
    - name: {{ s.dir.gelato }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
