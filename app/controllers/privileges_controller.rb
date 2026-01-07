# frozen_string_literal: true

class PrivilegesController < WulinMaster::ScreenController
  controller_for_screen PrivilegeScreen

  add_callback :query_ready, :filter_for_user

  def export_privilege_permission
    ids = params[:ids]

    privileges = if ids.present?
              Privilege.where(id: ids)
            else
              Privilege.all
            end

    privileges = privileges.includes(:permissions)

    payload = privileges.map do |p|
      {
        name: p.name,
        description: p.description,
        permissions: p.permissions.order(:id).pluck(:name)
      }
    end

    filename = "privileges_permissions_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}.json"

    send_data JSON.pretty_generate(payload),
              type: 'application/json',
              disposition: 'attachment',
              filename: filename
  end

  def import_privilege_permission
    begin
      file = params[:import_privilege_permission_file]

      if file.blank?
        render json: { error: 'No file provided' }, status: :bad_request
        return
      end

      # Read and parse JSON file
      file_content = file.read
      privileges_data = JSON.parse(file_content)

      ActiveRecord::Base.transaction do
        privileges_data.each do |privilege_data|
          privilege_name = privilege_data['name']
          privilege_description = privilege_data['description']
          permission_names = privilege_data['permissions'] || []

          # Find or create privilege
          privilege = Privilege.find_by(name: privilege_name)
          if privilege
            # Update existing privilege
            privilege.update!(description: privilege_description) if privilege_description.present?
          else
            # Create new privilege
            privilege = Privilege.create!(name: privilege_name, description: privilege_description)
          end

          # Add permissions (only if they don't already exist)
          permission_names.each do |permission_name|
            # Find or create permission
            permission = Permission.find_or_create_by(name: permission_name)

            # Create the association only if it doesn't exist
            PermissionsPrivilege.find_or_create_by(privilege: privilege, permission: permission)
          end
        end
      end

      render json: {
        message: "Import successful!"
      }

    rescue JSON::ParserError
      render json: { error: 'Invalid JSON format' }, status: :bad_request
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "Database error: #{e.message}" }, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: "Import failed: #{e.message}" }, status: :internal_server_error
    end
  end

  private

  def filter_for_user
    user_filter_params = params[:filters].to_a.find { |x| x.values.include?("user_id") and x.values.include?("exclude") }
    return if user_filter_params.blank?

    privilege_ids = UsersPrivilege.where(user_id: user_filter_params[:value]).pluck(:privilege_id).uniq

    if privilege_ids.present?
      @query = @query.where.not(id: privilege_ids)
    end
  end
end
