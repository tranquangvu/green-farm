class ContactsController < ApplicationController
  def create
    contact = Contact.new(contact_params)

    if contact.save
      redirect_to thanks_you_contacts_path
    else
      redirect_to root_path, notice: "Your submit can't be save. Please try again"
    end
  end

  def thanks_you
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :first_name, :last_name, :phone_number, :message)
  end
end
