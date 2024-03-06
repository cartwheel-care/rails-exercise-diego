class ContactsController < ApplicationController
  def index
    @contacts = Contact.all.order(:first_name, :last_name)
  end

  def make_patient
    @contact = Contact.find(params[:id])

    @contact.create_patient(first_name: @contact.first_name, last_name: @contact.last_name, avatar_url: Patient::DEFAULT_AVATAR)

    flash[:info] = 'Patient successfully created'
    redirect_to action: :index
  end
end
