# frozen_string_literal: true

module WulinPermits
  module UserManagement
    SCREEN_READ = "master_user_detail_role#read"
    SCREEN_CUD = "master_user_detail_role#cud"
    REVERSE_SCREEN_READ = "master_role_detail_user#read"
    REVERSE_SCREEN_CUD = "master_role_detail_user#cud"
    INVITE = "users#invite"
    RESET = "users#send_mail"
    DELETE = "users#destroy"
    CUD = "users#cud"

    PERMISSIONS = [
      SCREEN_READ,
      SCREEN_CUD,
      REVERSE_SCREEN_READ,
      REVERSE_SCREEN_CUD,
      INVITE,
      RESET,
      DELETE,
      CUD
    ].freeze
  end
end
