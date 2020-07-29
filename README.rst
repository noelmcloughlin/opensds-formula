======================
sodafoundation-formula
======================

Deploy official releases of SodaFoundation (www.sodafoundation.io) using Salt on CENTOS, UBUNTU, and OPENSUSE. This is an experimental solution using repeatable patterns to deploy cloud-native stack using infrastructure as code.  This formula compliments the SodaFoundation-Installer_ project.

.. _SodaFoundation-Installer: https://github.com/sodafoundation/sodafoundation-installer


.. notes::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Architectural View
==================

.. image:: solutionDesign.png
   :target: https://github.com/sodafoundation/sodafoundation
   :scale: 25 %
   :alt: salt formula high level architecture

Available META states
=====================

.. contents::
    :local:

``sodafoundation``
------------------

Runs all the other states in the formula. Used by the ``SodaFoundation-installer/salt`` module.

``sodafoundation.infra``
------------------------

Deploy os profile (PATHS) and environmental dependencies (packages, nginx, docker, etc) via salt.

``sodafoundation.telemetry``
----------------------------

Deploy prometheus and grafana via salt.

``sodafoundation.keystone``
---------------------------

Deploy devstack with keystone configuration for hotpot and gelato.

``sodafoundation.config``
-------------------------

Deploy sodafoundation configuration file

``sodafoundation.hotpot``
-------------------------

Deploy sodafoundation hotpot

``sodafoundation.auth``
-----------------------

Deploy authentication service (default keystone).

``sodafoundation.database``
---------------------------

Deploy database service (default etcd).

``sodafoundation.dock``
-----------------------

Deploy dock service.

``sodafoundation.sushi``
------------------------

Deploy North bound plugin service.

``sodafoundation.gelato``
-------------------------

Deploy multi-cloud service.

``sodafoundation.dashboard``
----------------------------

Deploy Dashboard service.

``sodafoundation.freespace``
----------------------------

Free some disk space


Site-specific Data Collection
=============================

The ``site.j2`` and ``pillar.example`` files contain required pillars!

You may review and cautiously update ``site.j2`` to reflect site requirements and preferences.

Prerequisite
============

Prepare your environment by running the ``salt.formulas`` state from ``https://github.com/saltstack-formulas/salt-formula``. See ``pillar.example`` and/or sodafoundation-installer/salt README.
