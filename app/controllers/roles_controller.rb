# frozen_string_literal: true

class RolesController < WulinMaster::ScreenController
  controller_for_screen RoleScreen

  def export_role_permission
    ids = params[:ids]

    roles = if ids.present?
              Role.where(id: ids)
            else
              Role.all
            end

    roles = roles.includes(:permissions)

    payload = roles.map do |role|
      {
        name: role.name,
        description: role.description,
        permissions: role.permissions.order(:id).pluck(:name)
      }
    end

    filename = "roles_permissions_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}.json"

    send_data JSON.pretty_generate(payload),
              type: 'application/json',
              disposition: 'attachment',
              filename: filename
  end

  def import_role_permission
    begin
      file = params[:import_role_permission_file]

      if file.blank?
        render json: { error: 'No file provided' }, status: :bad_request
        return
      end

      # Read and parse JSON file
      file_content = file.read
      roles_data = JSON.parse(file_content)

      ActiveRecord::Base.transaction do
        roles_data.each do |role_data|
          role_name = role_data['name']
          role_description = role_data['description']
          permission_names = role_data['permissions'] || []

          # Find or create role
          role = Role.find_by(name: role_name)
          if role
            # Update existing role
            role.update!(description: role_description) if role_description.present?

          else
            # Create new role
            role = Role.create!(name: role_name, description: role_description)
          end

          # Add permissions (only if they don't already exist)
          permission_names.each do |permission_name|
            # Find or create permission
            permission = Permission.find_or_create_by(name: permission_name)

            # Create the association only if it doesn't exist
            PermissionsRole.find_or_create_by(role: role, permission: permission)
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
end
