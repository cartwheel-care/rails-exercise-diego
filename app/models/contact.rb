class Contact < ApplicationRecord
  belongs_to :patient, optional: true
end
