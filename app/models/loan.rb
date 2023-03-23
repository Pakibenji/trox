class Loan < ApplicationRecord
    belongs_to :user
    belongs_to :tool
    validates :start_date, presence: true
    validates :end_date, presence: true
    validate :end_date_after_start_date

    def end_date_after_start_date
        if start_date.present? && end_date.present? && end_date <= start_date
          errors.add(:end_date, "must be after start date")
        end
      end
end
