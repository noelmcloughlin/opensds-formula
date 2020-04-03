###  soda/database/daemon/clean.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda, golang with context %}

include:
    {%- if 'etcd' in soda.database.daemon %}
        {%- if 'container' in soda.database.daemon.etcd.strategy|lower %}
  - etcd.docker.stopped
          {%- else %}
  - etcd.service.stopped
          {%- endif %}
  - etcd.remove
     {%- endif %}
  - soda.database.config.clean
