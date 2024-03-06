class Patient < ApplicationRecord
  DEFAULT_AVATAR = 'https://robohash.org/quitotamnon.png?size=300x300&set=set1'.freeze
  has_one :contact

  def full_name
    "#{first_name} #{last_name}"
  end
end
