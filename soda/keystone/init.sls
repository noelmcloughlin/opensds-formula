###  soda/keystone/init.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml
{%- from "soda/map.jinja" import soda with context %}

{%- if "keystone" in soda.controller.conf.let.auth_strategy|lower %}

include:
  - devstack.user
  - soda.keystone.conflicts.init
  - devstack.install
  {%- if grains.os_family == 'RedHat' %}
  - devstack.install       {# workaround https://github.com/saltstack-formulas/devstack-formula/issues/13 #}
  {%- endif %}
  - soda.keystone.conflicts.clean

{%- else %}

soda keystone init nothing to do:
  test.show_notification:
    - text: |
        Skipping keystone because `auth_strategy: noauth` (or something else) was configured!

{%- endif %}
