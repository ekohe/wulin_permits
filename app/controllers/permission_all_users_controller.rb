class PermissionAllUsersController < WulinMaster::ScreenController
  before_action :require_admin
  controller_for_screen MasterPermissionDetailUserScreen

  TEMP_USERS_TABLE = "disposable_permission_all_users"

  add_callback :query_initialized, :preload_relations

  unless defined? Mima
    after_action :remove_temp_users
    add_callback :query_initialized, :preload_users
    add_callback :query_initialized, :apply_permission_filter
    add_callback :objects_ready, :assign_emails
  end

  private

  def connection
    @connection ||= ActiveRecord::Base.connection
  end

  def apply_permission_filter
    if params[:screen] == "MasterPermissionDetailUserScreen" && params[:grid] == "PermissionAllUserGrid"
      filter_params = params[:filters].find { |x| x.value?("permission_id") }

      return if filter_params.blank?

      permission_id = filter_params[:value]

      params[:filters].delete filter_params

      @query = @query.where("#{PermissionAllUser.table_name}.permission_id = ?", permission_id)
    end
  end

  def preload_relations
    @query = if defined? Mima
      @query.includes(:permission, :user)
    else
      @query.includes(:permission)
    end
  end

  def preload_users
    if params[:screen] == "MasterPermissionDetailUserScreen" && params[:grid] == "PermissionAllUserGrid"
      @query = @query.joins("INNER JOIN #{TEMP_USERS_TABLE} ON #{TEMP_USERS_TABLE}.id = #{PermissionAllUser.table_name}.user_id")
      @user_id_emails = {}

      connection.execute "DROP TABLE IF EXISTS #{TEMP_USERS_TABLE}"
      connection.execute <<-SQL
        CREATE TEMPORARY TABLE #{TEMP_USERS_TABLE} (
          id SERIAL PRIMARY KEY,
          email VARCHAR(255)
        );
      SQL

      if params[:filters].present?
        filter_params = params[:filters].find { |x| x.value?("permission_id") }
        return if filter_params.blank?

        user_ids = grid.model.where(permission_id: filter_params[:value]).pluck(:user_id).uniq

        users = User.find_by_ids user_ids

        if users.any?
          values = users.map do |user|
            @user_id_emails[user.id] = user.email
            "(#{user.id}, '#{user.email}')"
          end.join(", ")

          sql = "INSERT INTO #{TEMP_USERS_TABLE} (id, email) VALUES #{values};"
          connection.execute(sql)
        end
      end
    end
  end

  def remove_temp_users
    if params[:screen] == "MasterPermissionDetailUserScreen" && params[:grid] == "PermissionAllUserGrid"
      connection.execute "DROP TABLE IF EXISTS #{TEMP_USERS_TABLE}"
    end
  end

  def assign_emails
    if params[:screen] == "MasterPermissionDetailUserScreen" && params[:grid] == "PermissionAllUserGrid"
      @objects = @objects.map do |obj|
        if @user_id_emails[obj.user_id].present?
          obj.email = @user_id_emails[obj.user_id]
          obj
        end
      end.compact
    end
  end
end
