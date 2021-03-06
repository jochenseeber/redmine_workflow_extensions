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
module RedmineWorkflowExtensions
    class IssueHooks < Redmine::Hook::ViewListener
        def update_closed_on(issue)
            if issue then
                if issue.status.is_closed? then
                    if issue.closed_on.nil? then
                        issue.closed_on = Time.now
                    end
                else
                    if not issue.closed_on.nil? then
                        issue.closed_on = nil
                    end
                end
            end
        end

        def controller_issues_new_before_save(context = {})
            issue = context[:issue]
            update_closed_on(issue)
        end

        def controller_issues_edit_before_save(context = {})
            issue = context[:issue]
            update_closed_on(issue)
        end

        def controller_issues_bulk_edit_before_save(context = {})
            issue = context[:issue]
            update_closed_on(issue)
        end
    end
end
