###  sodafoundation/infra/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "sodafoundation/map.jinja" import sodafoundation with context %}

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


    {%- if sodafoundation.pkgs and sodafoundation.pkgs is iterable and sodafoundation.pkgs is not string %}
        {%- for p in sodafoundation.pkgs %}
sodafoundation infra pkgs install {{ p }}:
  pkg.installed:
    - name: {{ p }}
        {%- endfor %}
    {%- endif %}
