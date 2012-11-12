#
# Copyright 2012 Jochen Seeber
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
module RedmineWorkflowExtensions
    module QueryPatch
        # :nodoc:
        def self.included(base)
            base.extend(ClassMethods)
            base.send(:include, InstanceMethods)
            base.class_eval do
                alias_method_chain :available_filters, :workflow_info
                class << self
                    alias_method_chain :available_columns, :workflow_info
                end
            end
        end

        module InstanceMethods
            #
            # Return extended filters
            #
            # - Add a close date filter
            #
            def available_filters_with_workflow_info
                filters = available_filters_without_workflow_info
                if not filters.include?('closed_on') then
                    filters['closed_on'] = {:type => :date_past, :order => 12, :name => l(:field_closed_on)}
                end
                filters
            end
        end

        module ClassMethods
            #
            # Return extended columns
            #
            # - Add a close date column
            #
            def available_columns_with_workflow_info
                columns = available_columns_without_workflow_info
                if (columns.find {|column| column.name == :closed_on}).nil? then
                    columns << QueryColumn.new(:closed_on, :sortable => "#{Issue.table_name}.closed_on")
                end
                columns
            end
        end
    end
end
