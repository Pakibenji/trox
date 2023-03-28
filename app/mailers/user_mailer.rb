class UserMailer < ApplicationMailer
    default from: 'troxmail@yopmail.com'

    def welcome_email(user)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = user 
  
      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'https://trox.fly.dev' 
  
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: 'Bienvenue chez nous !') 
    end

    def loan_email(user)
      @user = user

      @url = "https://trox.fly.dev"

      mail(to: @user.tool.user.email, subject: 'Un utilisateur a loué ton outil!')

    end
end
