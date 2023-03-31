class Loan < ApplicationRecord
    belongs_to :user # un emprunt est lié à un utilisateur
    belongs_to :tool # un emprunt est lié à un outil
    validates :start_date, presence: true # la date de début d'emprunt est obligatoire
    validates :end_date, presence: true # la date de fin d'emprunt est obligatoire
    validate :end_date_after_start_date # la date de fin d'emprunt doit être postérieure à la date de début d'emprunt
    after_create :mark_tool_as_loaned # après la création d'un emprunt, l'outil est marqué comme emprunté
    before_create :loaned_true_or_false # avant la création d'un emprunt, on vérifie que l'outil n'est pas déjà emprunté
    after_destroy :mark_tool_as_false # après la destruction d'un emprunt, l'outil est marqué comme non emprunté
    after_create :loan_send # après la création d'un emprunt, un mail est envoyé à l'utilisateur
    after_create :loan_confirmation_send # après la création d'un emprunt, un mail de confirmation est envoyé à l'utilisateur qui a possède l'outil
    validate :cant_loan_before_today # la date de début d'emprunt ne peut pas être antérieure à la date du jour
      # le loan_send permet d'envoyer un mail à l'utilisateur qui a emprunté l'outil.
    def loan_send
      UserMailer.loan_email(self).deliver_now
    end
      # le loan_confirmation_send permet d'envoyer un mail de confirmation à l'utilisateur qui a possède l'outil.
    def loan_confirmation_send
      UserMailer.loan_confirmation_email(self).deliver_now
    end

    private
      # le mark_tool_as_false permet de marquer l'outil comme non emprunté.
    def mark_tool_as_false
      tool.update(loaned: false)
    end

    # le mark_tool_as_loaned permet de marquer l'outil comme emprunté.
    def mark_tool_as_loaned
      tool.update(loaned: true)
    end


    # le end_date_after_start_date permet de vérifier que la date de fin d'emprunt est postérieure à la date de début d'emprunt.
    def end_date_after_start_date
        if start_date.present? && end_date.present? && end_date <= start_date
          errors.add(:end_date, "La date de retour doit être postérieure à la date d'emprunt")
        end
      end
    # le loaned_true_or_false permet de vérifier que l'outil n'est pas déjà emprunté.
      def loaned_true_or_false
        if tool.loaned?
          errors.add("cet objet est déjà emprunté")
      end
    end
    # le cant_loan_before_today permet de vérifier que la date de début d'emprunt n'est pas antérieure à la date du jour.
    def cant_loan_before_today
      if start_date.present? && start_date < Date.today
        errors.add(:start_date, "Date d'emprunt invalide")
      end
    end

end
