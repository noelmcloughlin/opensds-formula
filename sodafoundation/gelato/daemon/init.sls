###  sodafoundation/gelato/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "sodafoundation/map.jinja" import sodafoundation as s with context %}

    {%- if s.deploy_project not in ('hotpot',)  %}

{%- from "sodafoundation/map.jinja" import docker, packages, golang with context %}
{%- from 'sodafoundation/files/macros.j2' import build_source, cp_binaries with context %}
{%- from 'sodafoundation/files/macros.j2' import workflow, container_run, service_run with context %}

include:
  - sodafoundation.gelato.config
        {%- if "keystone" in s.hotpot.conf.let.auth_strategy|lower %}

  - devstack.cli
        {%- else %}

sodafoundation gelato daemon init skipping keystone:
  test.show_notification:
    - text: |
        Skipping keystone because `auth_strategy: noauth` (or something else) was configured!
        {%- endif %}

        {%- for id in s.gelato.ids %}
           {%- if 'daemon' in s.gelato and id in s.gelato.daemon %}
               {%- if s.gelato.daemon[ id ] is mapping %}

               {%- if id == 'multi-cloud' and grains.os_family in ('RedHat',) %}
sodafoundation gelato daemon {{ id }} workaround Failed-to-program-FILTER-chain:
  cmd.run:
    - name: systemctl restart docker
               {%- endif %}


{{ workflow('sodafoundation', 'gelato daemon', id, s.gelato, s.dir.gelato, s, golang) }}

               {%- endif %}
           {%- endif %}
        {%- endfor %}
    {%- endif %}
