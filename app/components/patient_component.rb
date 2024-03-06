# frozen_string_literal: true

class PatientComponent < ViewComponent::Base
  def initialize(patient, origin = :patients)
    @patient = patient
    @origin = origin
  end
end
