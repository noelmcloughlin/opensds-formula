###  soda/infra/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

include:
  {{ '- epel' if grains.os_family in ('RedHat',) else '' }}
      {%- if grains.os_family not in ('Suse',) %}
  - ceph.repo
      {%- endif %}
  - packages.pkgs
  - packages.pips
  - packages.archives
  - golang
  - timezone
  - resolver.ng
  - docker
  - memcached
  - mysql.apparmor
  - apache      ### manages port 80
  - nginx       ### manages port 8088 (daemon or container)


    {%- if soda.pkgs and soda.pkgs is iterable and soda.pkgs is not string %}
        {%- for p in soda.pkgs %}
soda infra pkgs install {{ p }}:
  pkg.installed:
    - name: {{ p }}
        {%- endfor %}
    {%- endif %}
