class UsersPrivilegesController < WulinMaster::ScreenController
  before_action :require_admin
  controller_for_screen MasterUserDetailPrivilegeScreen

  MIMA_TEMP_USERS_TABLE = "disposable_users_privileges"

  add_callback :query_initialized, :preload_relations

  unless defined? Mima
    after_action :remove_mima_users
    add_callback :query_initialized, :preload_users
    add_callback :query_initialized, :apply_user_filter
    add_callback :objects_ready, :assign_emails
  end

  private

  def connection
    @connection ||= ActiveRecord::Base.connection
  end

  def apply_user_filter
    if params[:screen] == "MasterUserDetailPrivilegeScreen" && params[:grid] == "UsersPrivilegeGrid"
      filter_params = params[:filters].find { |x| x.value?("user_id") }

      return if filter_params.blank?

      user_id = filter_params[:value]

      params[:filters].delete filter_params

      @query = @query.where("#{UsersPrivilege.table_name}.user_id = ?", user_id)
    end
  end

  def preload_relations
    @query = if defined? Mima
      @query.includes(:privilege, :user)
    else
      @query.includes(:privilege)
    end
  end

  def preload_users
    if params[:screen] == "MasterPrivilegeDetailUserScreen" && params[:grid] == "UsersPrivilegeGrid"
      @query = @query.joins("INNER JOIN #{MIMA_TEMP_USERS_TABLE} ON #{MIMA_TEMP_USERS_TABLE}.id = #{UsersPrivilege.table_name}.user_id")
      @user_id_emails = {}

      connection.execute "DROP TABLE IF EXISTS #{MIMA_TEMP_USERS_TABLE}"
      connection.execute <<-SQL
        CREATE TEMPORARY TABLE #{MIMA_TEMP_USERS_TABLE} (
          id SERIAL PRIMARY KEY,
          email VARCHAR(255)
        );
      SQL

      if params[:filters].present?
        filter_params = params[:filters].find { |x| x.value?("privilege_id") }
        return if filter_params.blank?

        user_ids = grid.model.where(privilege_id: filter_params[:value]).pluck(:user_id)

        users = User.find_by_ids user_ids

        if users.any?
          values = users.map do |user|
            @user_id_emails[user.id] = user.email
            "(#{user.id}, '#{user.email}')"
          end.join(", ")

          sql = "INSERT INTO #{MIMA_TEMP_USERS_TABLE} (id, email) VALUES #{values};"
          connection.execute(sql)
        end
      end
    end
  end

  def remove_mima_users
    if params[:screen] == "MasterPrivilegeDetailUserScreen" && params[:grid] == "UsersPrivilegeGrid"
      connection.execute "DROP TABLE IF EXISTS #{MIMA_TEMP_USERS_TABLE}"
    end
  end

  def assign_emails
    if params[:screen] == "MasterPrivilegeDetailUserScreen" && params[:grid] == "UsersPrivilegeGrid"
      @objects = @objects.map do |obj|
        if @user_id_emails[obj.user_id].present?
          obj.email = @user_id_emails[obj.user_id]
          obj
        end
      end.compact
    end
  end
end
