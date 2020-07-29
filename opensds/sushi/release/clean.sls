###  sodafoundation/sushi/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

   {%- if s.deploy_project not in ('gelato',)  %}
       {%- for id in s.sushi.ids %}
           {%- if id in s.sushi.daemon and "release" in s.sushi.daemon[id]['strategy']|lower %} 

sodafoundation sushi release {{ id }} download directory clean:
  file.absent:
    - name: {{ s.dir.sushi }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
