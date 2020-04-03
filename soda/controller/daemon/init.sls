###  soda/controller/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

  {%- if soda.deploy_project not in ('multicloud',)  %}

{%- from "soda/map.jinja" import packages, docker, golang with context %}
{%- from 'soda/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'soda/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - soda.controller.config

      {%- for id in soda.controller.ids %}
          {% if 'daemon' in soda.controller and id in soda.controller.daemon and soda.controller.daemon[id] is mapping %}

{{ workflow('soda', 'controller daemon', id, soda.controller, soda.dir.controller, soda, golang) }}

          {%- endif %}
      {%- endfor %}
  {%- endif %}
