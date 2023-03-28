class Loan < ApplicationRecord
    belongs_to :user
    belongs_to :tool
    validates :start_date, presence: true
    validates :end_date, presence: true
    validate :end_date_after_start_date
    after_create :mark_tool_as_loaned
    before_create :loaned_true_or_false
    after_destroy :mark_tool_as_false
    after_create :loan_send

    def loan_send
      UserMailer.loan_email(self).deliver_now
    end

    private

    def mark_tool_as_false
      tool.update(loaned: false)
    end

  
    def mark_tool_as_loaned
      tool.update(loaned: true)
    end

    def end_date_after_start_date
        if start_date.present? && end_date.present? && end_date <= start_date
          errors.add(:end_date, "must be after start date")
        end
      end

      def loaned_true_or_false
        if tool.loaned?
          errors.add("cet objet est déjà loué")
      end
    end
end
