class Tool < ApplicationRecord
    belongs_to :user # un outil est lié à un utilisateur
    has_one :loan # un outil est lié à un emprunt
    has_one_attached :pic # un outil est lié à une photo
    validates :title, presence: true, length: {maximum: 30, too_long:"%{count} caractères autorisés pour le titre" }, format: { with: /((\w+\s?-?\w+)(,|\z))/i, message: "Pas de caractères spéciaux dans le titre"} # le titre est obligatoire et ne peut pas dépasser 30 caractères
    validates :description, presence: true, length: { maximum: 500, too_long: "%{count} caractères autorisés pour la description" } # la description est obligatoire et ne peut pas dépasser 500 caractères
    validates :pic, presence: true # la photo est obligatoire
    validates :location, presence: true # la localisation est obligatoire
    validates :condition, presence: true, length: {maximum: 30,too_long:"%{count} caractères autorisés pour l'état de l'outil"} # l'état de l'outil est obligatoire et ne peut pas dépasser 30 caractères
    validates :caution, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10000, message: "La caution doit être comprise entre 0 et 10 000€" } # la caution est obligatoire et doit être comprise entre 0 et 10 000€
    after_initialize :set_defaults # après l'initialisation, les valeurs par défaut sont définies

    geocoded_by :full_address # la localisation est géocodée
    after_validation :geocode # après la validation, la localisation est géocodée
    
      # le full_address permet de définir l'adresse complète.
    def full_address 
      "#{location}"
    end

    private
 # le set_defaults permet de définir les valeurs par défaut, ici l'outil n'est pas emprunté.
    def set_defaults
      self.loaned ||= false
    end

end
