class Player < ActiveRecord::Base
    has_and_belongs_to_many :teams

    validates :first_name, :last_name, :gender, presence: true
end
