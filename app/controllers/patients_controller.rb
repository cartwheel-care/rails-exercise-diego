class PatientsController < ApplicationController
  def index
    @patients = Patient.all.order(:first_name, :last_name)
  end

  def sync
    @patient = Patient.find(params[:id])

    result = PatientSyncService.new(@patient).sync

    flash[result.flash_type] = result.flash_message
    redirect_to params[:button] == 'contacts' ? contacts_path : patients_path
  end
end
