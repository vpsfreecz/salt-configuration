salt-configuration
==================

Testing for possible changes:
-----------------------------

::

  salt-ssh 'node1.pgnd.*' state.apply test=True


Bootstrapping new node:
-----------------------

Make sure virtualization is enabled in BIOS.

Add new entry to `conf/roster`::

  NODE.LOC.vpsfree.cz: 172.16.254.254

Add `env/pillar/cz_vpsfree_<LOC>_<NODE>.sls` file. Edit to reflect node
hardware.::

  ssh root@172.16.254.254
  and accept hostkey

  # apply stage1
  salt-ssh 'NODE.LOC.*' state.apply cz_vpsfree_stage1

  reboot
  # verify, rinse and repeat

  # apply stage2
  salt-ssh 'NODE.LOC.*' state.apply cz_vpsfree_stage2
