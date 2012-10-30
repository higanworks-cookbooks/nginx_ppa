Description
===========

Add ppa repository and install nginx.

Requirements
============

* opscode cookbook apt. [https://github.com/opscode-cookbooks/apt](https://github.com/opscode-cookbooks/apt)

Attributes
==========

- default['nginx']['dir'] = "/etc/nginx"  
Nginx config directory. Used by nxscripts.


Scripts
=====

- nxensite  
nginx site enabler. Copy from opscode cookbook.
- nxdissite
nginx site disabler. Copy from opscode cookbook.


Usage
=====



Test Scenario for cucumber-chef
====

<pre><code>
  Background:
    * I have a server called "nginx"
    * "nginx" is running "ubuntu" "precise"
    #* "nginx" is running "ubuntu" "lucid"
    * "nginx" has been provisioned
    * the "apt::default" recipe has been added to the "nginx" run list
    * the "nginx_ppa::default" recipe has been added to the "nginx" run list
    * the chef-client has been run on "nginx"
    * I ssh to "nginx" with the following credentials:
      | username | keyfile |
      | root | ../.ssh/id_rsa |

  Scenario: Package nginx is installed from ppa.
    When package "nginx" should be installed
    Then I should see "nginx-full" in the output
      And I should see "nginx-common" in the output
      And I should see "nginx" in the output
    When I run "apt-key list"
      Then I should see "7F0CEB10" in the output
      And path "/etc/apt/sources.list.d/nginx-ppa-source.list" should exist                
</code></pre>
