###  sodafoundation/hotpot/release/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

   {%- if s.deploy_project not in ('gelato',)  %}
       {%- for id in s.hotpot.ids %}
           {%- if id in s.hotpot.daemon and 'release' in s.hotpot.daemon[id]['strategy']|lower %}

sodafoundation hotpot release {{ id }} download directory clean:
  file.absent:
    - name: {{ s.dir.hotpot }}/{{ id }}

           {%- endif %}
       {%- endfor %}
  {%- endif %}
