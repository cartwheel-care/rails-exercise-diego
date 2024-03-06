# frozen_string_literal: true

class ContactComponent < ViewComponent::Base
  def initialize(contact)
    @contact = contact
  end
end
