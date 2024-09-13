# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    # POST /resource
    def create
      build_resource(sign_up_params)
      assign_company_to_resource

      if resource.save
        process_resource_persistence
      else
        handle_failed_resource_persistence
      end
    end

    protected

    # Permit additional parameters for sign up
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[company_selection company_name])
    end

    private

    def assign_company_to_resource
      if params[:company_selection] == 'new'
        company = Company.create!(name: params[:company_name])
        resource.company = company
      else
        resource.company = Company.find(params[:company_selection])
      end
    end

    def process_resource_persistence
      yield resource if block_given?
      if resource.active_for_authentication?
        handle_successful_authentication
      else
        handle_inactive_authentication
      end
    end

    def handle_successful_authentication
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    end

    def handle_inactive_authentication
      set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end

    def handle_failed_resource_persistence
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
