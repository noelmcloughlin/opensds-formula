###  soda/database/daemon/init.sls
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "soda/map.jinja" import soda with context %}

include:
  - soda.database.config
    {%- if 'database' in soda.database.daemon %}
        {%- if 'etcd' in soda.database.daemon.database.strategy %}
  - etcd.install
  - etcd.linuxenv
            {%- if 'container' in soda.database.daemon.database.strategy %}
  - etcd.docker.running
            {%- else %}
  - etcd.service
            {%- endif %}
        {%- endif %}
    {%- endif %}
