class Tool < ApplicationRecord
    belongs_to :user
    has_one :loan
    validates :title, presence: true
    validates :description, presence: true
    validates :pic, presence: true 
    validates :location, presence: true
    validates :condition, presence: true
    validates :caution, presence: true

end
