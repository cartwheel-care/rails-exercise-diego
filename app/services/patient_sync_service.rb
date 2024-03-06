class PatientSyncService
  FlashResponse = Struct.new(:flash_type, :flash_message)

  PATIENT_ACTIONS = {
    create: -> (patient, api_result) { patient.update!(sicklie_id: api_result.body[:sicklie_id], sicklie_updated_at: Time.current) },
    update: -> (patient, _api_result) { patient.update!(sicklie_updated_at: Time.current) }
  }

  def initialize(patient)
    @patient = patient
  end

  def sync
    action = @patient.sicklie_id.blank? ? :create : :update

    sync_patient(action)
  end

  private

  def sync_patient(action)
    api_result = __send__(action)

    if api_result.success?
      PATIENT_ACTIONS[action].call(@patient, api_result)
      FlashResponse.new(:info, "Synced patient '#{@patient.full_name}' with Sicklie")
    else
      FlashResponse.new(:error, "Error syncing '#{@patient.full_name}': #{api_result.error_message}")
    end
  end

  def create
    result = SicklieApi.create_patient(
      first_name: @patient.first_name,
      last_name: @patient.last_name
    )
    SicklieApiResult.new(result)
  end

  def update
    result = SicklieApi.update_patient(
      sicklie_id: @patient.sicklie_id,
      first_name: @patient.first_name,
      last_name: @patient.last_name
    )
    SicklieApiResult.new(result)
  end
end
