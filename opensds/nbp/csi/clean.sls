# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "opensds/map.jinja" import opensds with context %}

include:
  - .config

opensds nbp {{ opensds.nbp.release.version }} {{ opensds.nbp.plugin_type }} kubernetes stop:
  cmd.run:
    - name: {{ opensds.nbp[opensds.nbp.plugin_type]['stopcmd']
    - cwd: {{ opensds.nbp.dir.work }}/{{ opensds.nbp.plugin_type }}
    - output_loglevel: quiet 
