Redmine Workflow Info Plugin
============================

Redmine Plugin that gathers (or at least some day will gather :-) workflow information on a ticket as it passes through
its life cycle.

Features
--------

* Record close date of an issue and provide a filter for it

Installation and Setup
----------------------

* The plugin requires at least Redmine 2.1

* Open a shell and cd into your Redmine installation directory

* Install the plugin

        cd plugins
        git clone https://github.com/jochenseeber/redmine_workflow_extensions.git
    
* Run the database migration

        RAILS_ENV=production rake redmine:plugins:migrate
    
* Restart Redmine

License
-------

This plugin is licensed under the [GNU Affero General Public License][agpl].

[agpl]: http://www.gnu.org/licenses/agpl-3.0.html "GNU Affero General Public License"
