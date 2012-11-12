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
class AddClosedOnToIssue < ActiveRecord::Migration
    def self.up
        change_table :issues do |t|
            t.datetime :closed_on
        end
        
        # Set close date on closed issues
        sql = <<-SQL
            update issues i
            left join issue_statuses s on i.status_id = s.id 
            set i.closed_on = (
                select max(j.created_on) from journals j
                left join journal_details d on j.id = d.journal_id
                where j.journalized_id = i.id and j.journalized_type = 'Issue'
                and d.prop_key = 'status_id'
            )
            where s.is_closed
        SQL
        ActiveRecord::Base.connection.execute(sql)
    end

    def self.down
        change_table :issues do |t|
            t.remove :closed_on
        end
    end
end
