class Match < ActiveRecord::Base
    has_one :team_a, class_name: 'Team', foreignKey: 'team_a_id'
    has_one :team_b, class_name: 'Team', foreignKey: 'team_b_id'
end
