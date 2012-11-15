#
# Copyright 2012 Jochen Seeber
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
require 'redmine'
require 'redmine_workflow_extensions/query_patch.rb'
require 'redmine_workflow_extensions/issue_listener.rb'

Redmine::Plugin.register :redmine_workflow_extensions do
    name 'Workflow Extensions plugin'
    author 'Jochen Seeber'
    description 'Plugin that records the issue close date and provides a filter for it'
    version '0.0.1'
    url 'https://github.com/jochenseeber/redmine_workflow_extensions'
    author_url 'http://www.noussommesdesoles.net'

    ActionDispatch::Reloader.to_prepare do
        # Apply patches on reload
        Query.send(:include, RedmineWorkflowExtensions::QueryPatch)
    end
end
